part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class InitialState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String errorMsg;

  ErrorAuthState(this.errorMsg);
}

class SuccessAuthState extends AuthState {
  final String? token;

  SuccessAuthState(this.token);
}
