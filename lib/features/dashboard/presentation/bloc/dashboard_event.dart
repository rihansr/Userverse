part of 'dashboard_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class OnFetchUsersEvent extends AuthEvent {
  OnFetchUsersEvent();
}
