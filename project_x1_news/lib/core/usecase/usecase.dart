import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
