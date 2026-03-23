import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../data/models/request/change_password_request_model.dart';
import '../../data/models/request/login_request_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;
  DashboardBloc? profileBloc;

  AuthBloc({required this.repo, this.profileBloc}) : super(AuthInitialState()) {
    on<LoginEvent>(_onLogin);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(type: AuthType.login));

    final response = await repo.login(request: event.request);

    response.fold(
      (failure) => emit(
        AuthFailureState(type: AuthType.login, message: failure.toString()),
      ),
      (response) {
        profileBloc?.add(GetProfileEvent(profile: response.responseBody!));
        emit(
          AuthSuccessState(
            type: AuthType.login,
            message: response.responseMessage!,
          ),
        );
      },
    );
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState(type: AuthType.changePassword));

    final response = await repo.changePassword(request: event.request);

    response.fold(
      (failure) => emit(
        AuthFailureState(
          type: AuthType.changePassword,
          message: failure.toString(),
        ),
      ),
      (response) => emit(
        AuthSuccessState(
          type: AuthType.changePassword,
          message: response.responseMessage!,
        ),
      ),
    );
  }
}
