part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class OnRetrieveUserEvent extends UserEvent {
  final int id;
  OnRetrieveUserEvent(this.id);
}
