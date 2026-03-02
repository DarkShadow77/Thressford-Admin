import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/login_request_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;

  AuthBloc({required this.repo}) : super(AuthInitialState()) {
    // on<LoginEvent>(_onLogin);
  }

  /*Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(type: AuthType.login));

    final response = await repo.login(request: event.request);

    response.fold(
      (failure) => emit(
        AuthFailureState(type: AuthType.login, message: failure.toString()),
      ),
      (response) => emit(
        AuthSuccessState(
          type: AuthType.login,
          message: response.responseMessage!,
        ),
      ),
    );
  }*/
}
