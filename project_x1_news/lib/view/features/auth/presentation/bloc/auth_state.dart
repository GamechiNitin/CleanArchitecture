part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class LoadingAuth extends AuthState {}

final class SuccessAuth extends AuthState {
  final User uid;

  const SuccessAuth(this.uid);
}

final class FailureAuth extends AuthState {
  final String message;

  const FailureAuth(this.message);
}
