part of 'users_bloc.dart';

enum UsersType {
  getAllUsers,
  deleteUser,
  deactivateUser,
  suspendUser,
  unsuspendUser,
}

@immutable
class UsersState extends Equatable {
  final List<UsersModel> users;

  const UsersState({required this.users});

  UsersState copyWith({List<UsersModel>? users}) {
    return UsersState(users: users ?? this.users);
  }

  @override
  List<Object?> get props => [users];
}

final class UsersInitialState extends UsersState {
  const UsersInitialState({required super.users});

  @override
  List<Object> get props => [];
}

class UsersLoadingState extends UsersState {
  final UsersType type;
  final String? data;

  const UsersLoadingState({
    required this.type,
    this.data,
    required super.users,
  });
  @override
  List<Object?> get props => [type, data];
}

class UsersSuccessState extends UsersState {
  final String message;
  final UsersType type;
  final String? data;

  const UsersSuccessState({
    required this.message,
    required this.type,
    this.data,
    required super.users,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class UsersFailureState extends UsersState {
  final String message;
  final UsersType type;
  final String? data;

  const UsersFailureState({
    required this.message,
    required this.type,
    this.data,
    required super.users,
  });
  @override
  List<Object?> get props => [type, message, data];
}
