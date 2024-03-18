import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> logIn({
    required String email,
    required String password,
  });
}
