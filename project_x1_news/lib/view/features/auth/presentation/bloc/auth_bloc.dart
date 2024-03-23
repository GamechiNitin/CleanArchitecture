import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/view/features/auth/domain/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_login.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_authSignUpEvent);
    on<AuthSignInEvent>(_authSignInEvent);
  }

  FutureOr<void> _authSignUpEvent(
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

  FutureOr<void> _authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth());
    final response = await _userLogin(
      UserLoginParams(
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
