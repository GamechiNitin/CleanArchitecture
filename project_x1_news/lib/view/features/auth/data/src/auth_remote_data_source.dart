import 'dart:developer';
import 'package:project_x1_news/core/error/exceptions.dart';
import 'package:project_x1_news/view/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logIn({
    required String email,
    required String password,
  });
  Future<UserModel?> getUserCurrentData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

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
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }

  @override
  Future<UserModel?> getUserCurrentData() async {
    try {
      if (currentUserSession != null) {
        final response = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        return UserModel.fromJson(response.first);
      }

      return null;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException("$e");
    }
  }
}
