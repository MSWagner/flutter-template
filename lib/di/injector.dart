import 'dart:io';
import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/bridge/logging/logging_bridge.dart';
import 'package:flutter_template/bridge/logging/logging_bridging.dart';
import 'package:flutter_template/features/debug/repositories/debug_repo.dart';
import 'package:flutter_template/repositories/locale/locale_repo.dart';
import 'package:flutter_template/features/login/repositories/login_repo.dart';
import 'package:flutter_template/features/login/repositories/login_repository.dart';
import 'package:flutter_template/repositories/refresh/refresh_repo.dart';
import 'package:flutter_template/repositories/refresh/refresh_repository.dart';
import 'package:flutter_template/repositories/shared_prefs/local/local_storage.dart';
import 'package:flutter_template/repositories/shared_prefs/local/local_storing.dart';
import 'package:flutter_template/util/connectivity/connectivity_controller.dart';
import 'package:flutter_template/util/connectivity/connectivity_controlling.dart';
import 'package:flutter_template/features/todo/viewmodels/todo_add_viewmodel.dart';
import 'package:flutter_template/features/todo/viewmodels/todo_list_viewmodel.dart';
import 'package:kiwi/kiwi.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_template/database/todo/todo_dao_storage.dart';
import 'package:flutter_template/database/todo/todo_dao_storing.dart';
import 'package:flutter_template/database/flutter_template_database.dart';
import 'package:flutter_template/repositories/shared_prefs/shared_prefs_storage.dart';
import 'package:flutter_template/features/todo/repositories/todo_repo.dart';
import 'package:flutter_template/features/debug/repositories/debug_repository.dart';
import 'package:flutter_template/repositories/locale/locale_repository.dart';
import 'package:flutter_template/repositories/shared_prefs/shared_prefs_storing.dart';
import 'package:flutter_template/features/todo/repositories/todo_repository.dart';
import 'package:flutter_template/util/logger/flutter_template_logger.dart';
import 'package:flutter_template/util/env/flavor_config.dart';
import 'package:flutter_template/util/interceptor/network_log_interceptor.dart';
import 'package:flutter_template/features/license/viewmodels/license_viewmodel.dart';
import 'package:flutter_template/features/debug/viewModels/debug_platform_selector_viewmodel.dart';
import 'package:flutter_template/features/debug/viewModels/debug_viewmodel.dart';
import 'package:flutter_template/common/viewmodels/global_viewmodel.dart';
import 'package:flutter_template/features/splash/viewmodels/splash_viewmodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/repositories/secure_storage/auth/auth_storage.dart';
import 'package:flutter_template/repositories/secure_storage/auth/auth_storing.dart';
import 'package:flutter_template/repositories/secure_storage/secure_storage.dart';
import 'package:flutter_template/repositories/secure_storage/secure_storing.dart';
import 'package:flutter_template/util/interceptor/combining_smart_interceptor.dart';
import 'package:flutter_template/util/interceptor/network_auth_interceptor.dart';
import 'package:flutter_template/util/interceptor/network_error_interceptor.dart';
import 'package:flutter_template/util/interceptor/network_refresh_interceptor.dart';
import 'package:flutter_template/features/login/viewmodels/login_viewmodel.dart';
import 'package:flutter_template/networking/todo/todo_dummy_service.dart';
import 'package:flutter_template/networking/todo/todo_service.dart';
import 'package:flutter_template/networking/todo/todo_webservice.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(NetworkLogInterceptor)
  @Register.singleton(NetworkAuthInterceptor)
  @Register.singleton(NetworkErrorInterceptor)
  @Register.singleton(NetworkRefreshInterceptor)
  void registerNetworkDependencies();

  @Register.singleton(TodoDaoStoring, from: TodoDaoStorage)
  void registerDatabase();

  @Register.singleton(LoggingBridging, from: LoggingBridge)
  void registerBridge();

  @Register.singleton(TodoService, from: TodoWebService)
  void registerWebservices();

  @Register.singleton(TodoService, from: TodoDummyService)
  void registerDummyServices();

  @Register.singleton(TodoRepo, from: Todorepositories)
  @Register.singleton(LoginRepo, from: Loginrepositories)
  @Register.singleton(RefreshRepo, from: Refreshrepositories)
  @Register.singleton(DebugRepo, from: Debugrepositories)
  @Register.singleton(LocaleRepo, from: Localerepositories)
  void registerRepositories();

  @Register.singleton(SharedPrefsStoring, from: SharedPrefsStorage)
  @Register.singleton(LocalStoring, from: LocalStorage)
  @Register.singleton(SecureStoring, from: SecureStorage)
  @Register.singleton(AuthStoring, from: AuthStorage)
  @Register.singleton(ConnectivityControlling, from: ConnectivityController)
  void registerCommonDependencies();

  @Register.factory(GlobalViewModel)
  @Register.factory(SplashViewModel)
  @Register.factory(DebugViewModel)
  @Register.factory(DebugPlatformSelectorViewModel)
  @Register.factory(LicenseViewModel)
  @Register.factory(TodoListViewModel)
  @Register.factory(TodoAddViewModel)
  @Register.factory(LoginViewModel)
  void registerViewModelFactories();

  @Register.singleton(FlutterSecureStorage)
  @Register.singleton(Connectivity)
  void registerThirdPartyServices();
}

Future<void> setupDependencyTree() async {
  await provideSharedPreferences();
  final injector = _$Injector()..registerNetworkDependencies();
  await provideDatabaseConnection();
  KiwiContainer().registerSingleton((c) => provideFlutterTemplateDatabase(c.resolve()));
  KiwiContainer().registerSingleton((c) => provideCombiningSmartInterceptor(c.resolve(), c.resolve(), c.resolve(), c.resolve()));
  KiwiContainer().registerSingleton((c) => provideDio(c.resolve()));

  injector.registerThirdPartyServices();

  if (FlavorConfig.isDummy()) {
    injector.registerDummyServices();
  } else {
    injector.registerWebservices();
  }
  injector
    ..registerBridge()
    ..registerDatabase()
    ..registerCommonDependencies()
    ..registerRepositories()
    ..registerViewModelFactories();
}

Future<void> provideSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  KiwiContainer().registerSingleton((c) => sharedPreferences);
}

//Networking
CombiningSmartInterceptor provideCombiningSmartInterceptor(
  NetworkLogInterceptor logInterceptor,
  NetworkAuthInterceptor authInterceptor,
  NetworkErrorInterceptor errorInterceptor,
  NetworkRefreshInterceptor refreshInterceptor,
) =>
    CombiningSmartInterceptor()..addInterceptor(authInterceptor)..addInterceptor(refreshInterceptor)..addInterceptor(errorInterceptor)..addInterceptor(logInterceptor);

Dio provideDio(NetworkLogInterceptor networkInterceptor) {
  final dio = Dio();
  dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
  dio.interceptors.add(networkInterceptor);
  return dio;
}

//end Networking

//Database
FlutterTemplateDatabase provideFlutterTemplateDatabase(DatabaseConnection databaseConnection) => FlutterTemplateDatabase.connect(databaseConnection);

Future<void> provideDatabaseConnection() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(join(dbFolder.path, 'db.sqlite'));
  if ((FlavorConfig.isDev() || FlavorConfig.isDummy()) && file.existsSync()) {
    file.deleteSync();
    FlutterTemplateLogger.logVerbose('Databasefile `db.sqlite` is deleted');
  }
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, file.path),
  );

  // ignore: avoid_as
  final isolate = await receivePort.first as MoorIsolate;
  final databaseConnection = await isolate.connect();

  KiwiContainer().registerSingleton((c) => databaseConnection);
}

void _startBackground(_IsolateStartRequest request) {
  final executor = VmDatabase(File(request.targetPath));
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  request.sendMoorIsolate.send(moorIsolate);
}

class _IsolateStartRequest {
  final SendPort sendMoorIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendMoorIsolate, this.targetPath);
}
//end Database
