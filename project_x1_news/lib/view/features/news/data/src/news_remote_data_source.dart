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

  Future<List<NewsModel>> getNewsListData();
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
    } on PostgrestException catch (e) {
      throw ServerException("$e");
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }

  @override
  Future<String> uploadNewsImage({
    required NewsModel newsModel,
    required File image,
  }) async {
    try {
      await supabaseClient.storage.from('news_images').upload(
            newsModel.id,
            image,
          );
      return supabaseClient.storage
          .from('news_images')
          .getPublicUrl(newsModel.id);
    } on StorageException catch (e) {
      throw ServerException("$e");
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }

  @override
  Future<List<NewsModel>> getNewsListData() async {
    try {
      final response =
          await supabaseClient.from('news').select('*,profiles (name)');

      return response
          .map((e) =>
              NewsModel.fromJson(e).copyWith(posterName: e['profiles']['name']))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException("$e");
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }
}
