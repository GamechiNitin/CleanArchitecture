import 'package:get_it/get_it.dart';
import 'package:project_x1_news/view/features/auth/data/repo/auth_repository_impl.dart';
import 'package:project_x1_news/view/features/auth/data/src/remote_data_source.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';
import 'package:project_x1_news/view/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/error/secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final Supabase supabase = await Supabase.initialize(
    url: AppSecrets.secret,
    anonKey: AppSecrets.anon,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
