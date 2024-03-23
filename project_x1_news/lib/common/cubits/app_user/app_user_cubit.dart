import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/core/enities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    if (user != null) {
      emit(AppUserLoggedIn(user));
    } else {
      emit(AppUserInitial());
    }
  }
}
