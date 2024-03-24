import 'package:get_it/get_it.dart';
import 'package:project_x1_news/common/cubits/app_user/app_user_cubit.dart';
import 'package:project_x1_news/view/features/auth/data/repo/auth_repository_impl.dart';
import 'package:project_x1_news/view/features/auth/data/src/auth_remote_data_source.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_login.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_session.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';
import 'package:project_x1_news/view/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project_x1_news/view/features/news/data/repo/news_repo_impl.dart';
import 'package:project_x1_news/view/features/news/data/src/news_remote_data_source.dart';
import 'package:project_x1_news/view/features/news/domain/repository/news_repository.dart';
import 'package:project_x1_news/view/features/news/domain/usecases/upload_news.dart';
import 'package:project_x1_news/view/features/news/presentation/bloc/news_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/error/secrets.dart';

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
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));

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
      () => NewsRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<NewsRepository>(
      () => NewsRepositoryImpl(serviceLocator()),
    )
    // UseCase
    ..registerFactory(() => UploadNewsUseCase(serviceLocator()))
    // Bloc
    ..registerLazySingleton<NewsBloc>(() => NewsBloc(serviceLocator()));
}
