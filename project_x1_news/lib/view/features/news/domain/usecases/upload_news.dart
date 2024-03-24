import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';
import 'package:project_x1_news/view/features/news/domain/repository/news_repository.dart';

class UploadNewsUseCase implements UseCase<News, UploadNewsParams> {
  final NewsRepository newsRepository;

  UploadNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, News>> call(UploadNewsParams params) async {
    return await newsRepository.uploadNews(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topic: params.topic,
    );
  }
}

class UploadNewsParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topic;

  UploadNewsParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topic,
  });
}
