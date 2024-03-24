import 'dart:developer';
import 'dart:io';

import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/view/features/news/data/model/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NewsRemoteDataSource {
  Future<NewsModel> uploadNews(NewsModel newsModel);
  Future<String> uploadNewsImage({
    required NewsModel newsModel,
    required File image,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final SupabaseClient supabaseClient;
  NewsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<NewsModel> uploadNews(NewsModel newsModel) async {
    try {
      final response =
          await supabaseClient.from('news').insert(newsModel.toJson()).select();

      return NewsModel.fromJson(response.first);
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }

  @override
  Future<String> uploadNewsImage(
      {required NewsModel newsModel, required File image}) async {
    try {
      await supabaseClient.storage.from('news_images').upload(
            newsModel.id,
            image,
          );
      return supabaseClient.storage
          .from('news_images')
          .getPublicUrl(newsModel.id);
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }
}
