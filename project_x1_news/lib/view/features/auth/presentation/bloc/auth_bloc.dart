import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/view/features/auth/domain/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(authSignUpEvent);
  }

  FutureOr<void> authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth());
    final response = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    log(response.toString());
    response.fold((l) {
      emit(StopLoadingAuth());
      emit(FailureAuth(l.message));
    }, (r) {
      emit(StopLoadingAuth());
      emit(SuccessAuth(r));
    });
  }
}
