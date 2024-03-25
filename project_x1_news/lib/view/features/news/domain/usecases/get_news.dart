import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';
import 'package:project_x1_news/view/features/news/domain/repository/news_repository.dart';

class GetNewsUseCase implements UseCase<List<News>, NoParams> {
  final NewsRepository newsRepository;

  GetNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await newsRepository.getNewsData();
  }
}
