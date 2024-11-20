part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class OnLoginEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginEvent(this.email, this.password);
}