part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();
}

class OnFetchUsersEvent extends DashboardEvent {
  OnFetchUsersEvent();
}
