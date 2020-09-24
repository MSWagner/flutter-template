import 'package:dio/dio.dart';
import 'package:flutter_template/database/flutter_template_database.dart';
import 'package:flutter_template/database/todo/todo_dao_storing.dart';
import 'package:flutter_template/features/debug/repositories/debug_repo.dart';
import 'package:flutter_template/features/debug/viewmodels/debug_viewmodel.dart';
import 'package:flutter_template/features/debug/viewmodels/debug_platform_selector_viewmodel.dart';
import 'package:flutter_template/repositories/locale/locale_repo.dart';
import 'package:flutter_template/features/login/repositories/login_repo.dart';
import 'package:flutter_template/repositories/refresh/refresh_repo.dart';
import 'package:flutter_template/repositories/secure_storage/auth/auth_storing.dart';
import 'package:flutter_template/repositories/secure_storage/secure_storing.dart';
import 'package:flutter_template/repositories/shared_prefs/local/local_storing.dart';
import 'package:flutter_template/repositories/shared_prefs/shared_prefs_storing.dart';
import 'package:flutter_template/features/todo/repositories/todo_repo.dart';
import 'package:flutter_template/util/connectivity/connectivity_controlling.dart';
import 'package:flutter_template/common/viewmodels/global_viewmodel.dart';
import 'package:flutter_template/features/license/viewmodels/license_viewmodel.dart';
import 'package:flutter_template/features/login/viewmodels/login_viewmodel.dart';
import 'package:flutter_template/features/splash/viewmodels/splash_viewmodel.dart';
import 'package:flutter_template/features/todo/viewmodels/todo_add_viewmodel.dart';
import 'package:flutter_template/features/todo/viewmodels/todo_list_viewmodel.dart';
import 'package:flutter_template/networking/todo/todo_service.dart';
import 'package:kiwi/kiwi.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../mocks/database/todo/mock_todo_dao_storage.dart';
import '../mocks/mock_flutter_secure_storage.dart';
import '../mocks/mock_shared_preferences.dart';
import '../mocks/repository/debug/mock_debug_repository.dart';
import '../mocks/repository/locale/mock_locale_repository.dart';
import '../mocks/repository/login/mock_login_repository.dart';
import '../mocks/repository/refresh/mock_refresh_repository.dart';
import '../mocks/repository/secure_storage/auth/mock_auth_storage.dart';
import '../mocks/repository/secure_storage/mock_secure_storage.dart';
import '../mocks/repository/shared_prefs/local/mock_local_storage.dart';
import '../mocks/repository/shared_prefs/mock_shared_prefs_storage.dart';
import '../mocks/repository/todo/mock_todo_repository.dart';
import '../mocks/util/mock_connectivity_controller.dart';
import '../mocks/viewmodel/debug/mock_debug_platform_selector_viewmodel.dart';
import '../mocks/viewmodel/debug/mock_debug_viewmodel.dart';
import '../mocks/viewmodel/global/mock_global_viewmodel.dart';
import '../mocks/viewmodel/license/mock_lisence_viewmodel.dart';
import '../mocks/viewmodel/login/mock_login_viewmodel.dart';
import '../mocks/viewmodel/splash/mock_splash_viewmodel.dart';
import '../mocks/viewmodel/todo/todo_add/mock_todo_add_viewmodel.dart';
import '../mocks/viewmodel/todo/todo_list/mock_todo_list_viewmodel.dart';
import '../mocks/webservice/mock_dio.dart';
import '../mocks/webservice/mock_todo_service.dart';

part 'test_injector.g.dart';

abstract class Injector {
  @Register.singleton(MockFlutterSecureStorage)
  @Register.singleton(MockSharedPreferences)
  @Register.singleton(Dio, from: MockDio)
  void registerMocks();

  @Register.singleton(FlutterTemplateDatabase)
  @Register.singleton(TodoDaoStoring, from: MockTodoDaoStorage)
  void registerDatabase();

  @Register.singleton(LoginRepo, from: MockLoginrepositories)
  @Register.singleton(TodoRepo, from: MockTodorepositories)
  @Register.singleton(DebugRepo, from: MockDebugrepositories)
  @Register.singleton(LocaleRepo, from: MockLocaleRepoitory)
  @Register.singleton(RefreshRepo, from: MockRefreshrepositories)
  void registerRepositories();

  @Register.singleton(SharedPrefsStoring, from: MockSharedPrefsStorage)
  @Register.singleton(SecureStoring, from: MockSecureStorage)
  @Register.singleton(AuthStoring, from: MockAuthStorage)
  @Register.singleton(LocalStoring, from: MockLocalStorage)
  @Register.singleton(ConnectivityControlling, from: MockConnectivityController)
  void registerCommonDependencies();

  @Register.singleton(TodoService, from: MockTodoService)
  void registerMockServices();

  @Register.singleton(GlobalViewModel, from: MockGlobalViewModel)
  @Register.singleton(SplashViewModel, from: MockSplashViewModel)
  @Register.singleton(DebugViewModel, from: MockDebugViewModel)
  @Register.singleton(DebugPlatformSelectorViewModel, from: MockDebugPlatformSelectorViewModel)
  @Register.singleton(LicenseViewModel, from: MockLicenseViewModel)
  @Register.singleton(TodoListViewModel, from: MockTodoListViewModel)
  @Register.singleton(TodoAddViewModel, from: MockTodoAddViewModel)
  @Register.singleton(LoginViewModel, from: MockLoginViewModel)
  void registerViewModelFactories();
}

Future<void> setupDependencyTree() async {
  KiwiContainer().registerSingleton<QueryExecutor>((c) => VmDatabase.memory());

  _$Injector()
    ..registerMocks()
    ..registerMockServices()
    ..registerDatabase()
    ..registerCommonDependencies()
    ..registerRepositories()
    ..registerViewModelFactories();
}
