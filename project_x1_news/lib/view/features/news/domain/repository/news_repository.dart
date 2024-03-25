import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';

abstract interface class NewsRepository {
  Future<Either<Failure, News>> uploadNews({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic,
  });
  Future<Either<Failure, List<News>>> getNewsData();
}
