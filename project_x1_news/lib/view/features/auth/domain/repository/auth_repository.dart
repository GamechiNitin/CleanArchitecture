import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/enities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
