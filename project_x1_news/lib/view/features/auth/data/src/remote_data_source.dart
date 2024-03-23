import 'dart:developer';
import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/view/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> logIn(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException("User is null");
      } else {
        return UserModel.fromJson(response.user!.toJson());
      }
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const ServerException("User is not created");
      } else {
        return UserModel.fromJson(response.user!.toJson());
      }
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }
}
