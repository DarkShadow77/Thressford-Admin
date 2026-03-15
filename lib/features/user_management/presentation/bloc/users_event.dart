part of 'users_bloc.dart';

@immutable
sealed class UsersEvent extends Equatable {
  const UsersEvent();
  @override
  List<Object?> get props => [];
}

class GetAllUsersEvent extends UsersEvent {
  const GetAllUsersEvent();
}

class DeleteUserEvent extends UsersEvent {
  final DeleteUserRequestModel request;

  const DeleteUserEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class DeactivateUserEvent extends UsersEvent {
  final String email;
  final UsersStatus status;

  const DeactivateUserEvent({required this.email, required this.status});
  @override
  List<Object?> get props => [email, status];
}

class SuspendUserEvent extends UsersEvent {
  final String email;
  final UsersStatus status;

  const SuspendUserEvent({required this.email, required this.status});
  @override
  List<Object?> get props => [email, status];
}

class UnsuspendUserEvent extends UsersEvent {
  final String email;
  final UsersStatus status;

  const UnsuspendUserEvent({required this.email, required this.status});
  @override
  List<Object?> get props => [email, status];
}
