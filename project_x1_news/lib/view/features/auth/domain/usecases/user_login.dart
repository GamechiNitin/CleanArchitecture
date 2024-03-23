import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/view/features/auth/domain/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
