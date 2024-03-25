part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initNews();
  final Supabase supabase = await Supabase.initialize(
    url: AppSecrets.secret,
    anonKey: AppSecrets.anon,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

  // Local DB init
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'news_list'));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerFactory(() => UserSession(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userSession: serviceLocator(),
        appUserCubit: serviceLocator()),
  );
}

void _initNews() {
  // Data Source
  serviceLocator
    ..registerFactory<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<NewsLocalDataSource>(
        () => NewsLocalDataSourceImpl(serviceLocator()))
    // Repository
    ..registerFactory<NewsRepository>(() => NewsRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
    // UseCase
    ..registerFactory(() => UploadNewsUseCase(serviceLocator()))
    ..registerFactory(() => GetNewsUseCase(serviceLocator()))
    // Bloc
    ..registerLazySingleton<NewsBloc>(
      () => NewsBloc(
        getNewsUseCase: serviceLocator(),
        uploadNewsUseCase: serviceLocator(),
      ),
    );
}
