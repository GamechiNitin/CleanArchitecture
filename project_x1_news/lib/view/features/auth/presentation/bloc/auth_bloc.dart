import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/common/cubits/app_user/app_user_cubit.dart';
import 'package:project_x1_news/core/usecase/usecase.dart';
import 'package:project_x1_news/core/enities/user.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_login.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_session.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserSession _userSession;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required UserSession userSession,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userSession = userSession,
        _appUserCubit = appUserCubit,
        super(LoadingAuth()) {
    on<AuthSignUpEvent>(_authSignUpEvent);
    on<AuthSignInEvent>(_authSignInEvent);
    on<AuthSessionEvent>(_authSessionEvent);
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
      _emitAuthSuccess(r, emit);
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
      _emitAuthSuccess(r, emit);
    });
  }

  FutureOr<void> _authSessionEvent(
      AuthSessionEvent event, Emitter<AuthState> emit) async {
    final response = await _userSession(NoParams());
    log(response.toString());
    response.fold(
      (l) {
        emit(FailureAuth(l.message));
      },
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(SuccessAuth(user));
  }
}
