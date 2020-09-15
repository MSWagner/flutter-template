// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void registerMocks() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => MockFlutterSecureStorage());
    container.registerSingleton((c) => MockSharedPreferences());
    container.registerSingleton<Dio>((c) => MockDio());
  }

  void registerDatabase() {
    final KiwiContainer container = KiwiContainer();
    container
        .registerSingleton((c) => FlutterTemplateDatabase(c<QueryExecutor>()));
    container.registerSingleton<TodoDaoStoring>((c) => MockTodoDaoStorage());
  }

  void registerRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<LoginRepo>((c) => MockLoginrepositories());
    container.registerSingleton<TodoRepo>((c) => MockTodorepositories());
    container.registerSingleton<DebugRepo>((c) => MockDebugrepositories());
    container.registerSingleton<LocaleRepo>((c) => MockLocaleRepoitory());
    container.registerSingleton<RefreshRepo>((c) => MockRefreshrepositories());
  }

  void registerCommonDependencies() {
    final KiwiContainer container = KiwiContainer();
    container
        .registerSingleton<SharedPrefsStoring>((c) => MockSharedPrefsStorage());
    container.registerSingleton<SecureStoring>((c) => MockSecureStorage());
    container.registerSingleton<AuthStoring>((c) => MockAuthStorage());
    container.registerSingleton<LocalStoring>((c) => MockLocalStorage());
    container.registerSingleton<ConnectivityControlling>(
        (c) => MockConnectivityController());
  }

  void registerMockServices() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<TodoService>((c) => MockTodoService());
  }

  void registerViewModelFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<GlobalViewModel>((c) => MockGlobalViewModel());
    container.registerSingleton<SplashViewModel>((c) => MockSplashViewModel());
    container.registerSingleton<DebugViewModel>((c) => MockDebugViewModel());
    container.registerSingleton<DebugPlatformSelectorViewModel>(
        (c) => MockDebugPlatformSelectorViewModel());
    container
        .registerSingleton<LicenseViewModel>((c) => MockLicenseViewModel());
    container
        .registerSingleton<TodoListViewModel>((c) => MockTodoListViewModel());
    container
        .registerSingleton<TodoAddViewModel>((c) => MockTodoAddViewModel());
    container.registerSingleton<LoginViewModel>((c) => MockLoginViewModel());
  }
}
