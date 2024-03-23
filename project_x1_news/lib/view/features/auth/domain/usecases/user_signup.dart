import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/core/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
