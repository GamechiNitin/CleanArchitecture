import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/network/connection_checker.dart';
import 'package:project_x1_news/view/features/auth/data/src/auth_remote_data_source.dart';
import 'package:project_x1_news/core/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker checker;
  AuthRepositoryImpl(this.authRemoteDataSource, this.checker);

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
      if (await checker.isConnected) {
        final user = await authRemoteDataSource.signUp(
          name: name,
          email: email,
          password: password,
        );
        return right(user);
      } else {
        return left(Failure(message: 'No internet'));
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  // Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
  //   try {
  //     final user = await fn();
  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(message: e.message));
  //   }
  // }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (await checker.isConnected) {
        final user = await authRemoteDataSource.getUserCurrentData();
        if (user != null) {
          return right(user);
        } else {
          return left(Failure(message: "User not logged in"));
        }
      } else {
        final session = authRemoteDataSource.currentUserSession;
        if (session != null) {
          return right(User(id: session.user.id, email: session.user.email));
        } else {
          return left(Failure(message: 'User not logged in !'));
        }
      }
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
