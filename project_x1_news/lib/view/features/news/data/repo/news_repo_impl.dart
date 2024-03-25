import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/core/error/failured.dart';
import 'package:project_x1_news/view/features/news/data/model/news_model.dart';
import 'package:project_x1_news/view/features/news/data/src/news_remote_data_source.dart';
import 'package:project_x1_news/view/features/news/domain/entities/news.dart';
import 'package:project_x1_news/view/features/news/domain/repository/news_repository.dart';
import 'package:uuid/uuid.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, News>> uploadNews(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topic}) async {
    try {
      NewsModel newsModel = NewsModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: 'imageUrl',
        topic: topic,
        updateAt: DateTime.now(),
      );
      final imageURL = await remoteDataSource.uploadNewsImage(
        image: image,
        newsModel: newsModel,
      );
      newsModel = newsModel.copyWith(imageUrl: imageURL);

      final data = await remoteDataSource.uploadNews(newsModel);
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<News>>> getNewsData() async {
    try {
      final data = await remoteDataSource.getNewsListData();

      return right(data);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
