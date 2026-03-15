part of 'auth_bloc.dart';

enum AuthType { login, changePassword }

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitialState extends AuthState {
  const AuthInitialState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  final AuthType type;
  final String? data;

  const AuthLoadingState({required this.type, this.data});
  @override
  List<Object?> get props => [type, data];
}

class AuthSuccessState extends AuthState {
  final String message;
  final AuthType type;
  final String? data;

  const AuthSuccessState({
    required this.message,
    required this.type,
    this.data,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class AuthFailureState extends AuthState {
  final String message;
  final AuthType type;
  final String? data;

  const AuthFailureState({
    required this.message,
    required this.type,
    this.data,
  });
  @override
  List<Object?> get props => [type, message, data];
}
