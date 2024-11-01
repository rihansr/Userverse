part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class LoadingRetrieveUserState extends UserState {}

class ErrorRetrieveUserState extends UserState {
  final String errorMessage;

  ErrorRetrieveUserState(this.errorMessage);
}

class SuccessRetrieveUserState extends UserState {}
