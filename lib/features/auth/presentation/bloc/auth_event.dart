part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginRequestModel request;

  const LoginEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class ChangePasswordEvent extends AuthEvent {
  final ChangePasswordRequestModel request;

  const ChangePasswordEvent({required this.request});
  @override
  List<Object?> get props => [request];
}
