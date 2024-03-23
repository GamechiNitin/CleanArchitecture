part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingAuth extends AuthState {}

final class StopLoadingAuth extends AuthState {}

final class SuccessAuth extends AuthActionState {
  final User uid;

  SuccessAuth(this.uid);
}

final class FailureAuth extends AuthActionState {
  final String message;

  FailureAuth(this.message);
}
