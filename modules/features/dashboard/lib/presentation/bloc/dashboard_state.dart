part of 'dashboard_bloc.dart';

abstract class DashboardState {
  const DashboardState();
}

class LoadingFetchUsersState extends DashboardState {}

class ErrorFetchUsersState extends DashboardState {
  final String errorMessage;

  ErrorFetchUsersState(this.errorMessage);
}

class SuccessFetchUsersState extends DashboardState {}

class EmptyUsersState extends DashboardState {}
