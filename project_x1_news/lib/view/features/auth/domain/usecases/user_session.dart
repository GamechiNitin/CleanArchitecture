import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/core/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';

class UserSession implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  UserSession(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
