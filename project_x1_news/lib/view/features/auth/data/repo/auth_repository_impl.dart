import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/view/features/auth/data/src/remote_data_source.dart';
import 'package:project_x1_news/view/features/auth/domain/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.logIn(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
