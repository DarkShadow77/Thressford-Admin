import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:thressford_admin/features/user_management/data/models/response/users_response_model.dart';

import '../../../../core/session/session_manager.dart';
import '../../../../core/utils/local_storage.dart';
import '../../data/models/request/delete_user_request_model.dart';
import '../../data/models/request/update_user_status_request_model.dart';
import '../../data/models/users_management_status_enum.dart';
import '../../domain/repositories/user_management_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserManagementRepository repo;
  final LocalStorageHelper _localStorage = LocalStorageHelper();

  UsersBloc({required this.repo}) : super(UsersInitialState(users: [])) {
    on<GetAllUsersEvent>(_onGetAllUsers);
    on<DeleteUserEvent>(_onDeleteUser);
    on<DeactivateUserEvent>(_onDeactivateUser);
    on<SuspendUserEvent>(_onSuspendUser);
    on<UnsuspendUserEvent>(_onUnsuspendUser);
  }

  Future<void> _onGetAllUsers(
    GetAllUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState(type: UsersType.getAllUsers, users: state.users));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.getAllUsers();

    response.fold(
      (failure) => emit(
        UsersFailureState(
          type: UsersType.getAllUsers,
          message: failure.toString(),
          users: state.users,
        ),
      ),
      (response) {
        emit(state.copyWith(users: response.responseBody));
        emit(
          UsersSuccessState(
            type: UsersType.getAllUsers,
            message: response.responseMessage!,
            users: response.responseBody!,
          ),
        );
      },
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState(type: UsersType.deleteUser, users: state.users));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.deleteUser(request: event.request);

    response.fold(
      (failure) => emit(
        UsersFailureState(
          type: UsersType.deleteUser,
          message: failure.toString(),
          users: state.users,
        ),
      ),
      (response) => emit(
        UsersSuccessState(
          type: UsersType.deleteUser,
          message: response.responseMessage!,
          users: state.users,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onDeactivateUser(
    DeactivateUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState(type: UsersType.deactivateUser, users: state.users));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateUserStatus(
      request: UpdateUserStatusRequestModel(
        token: await _localStorage.getAccessToken() ?? "",
        email: event.email,
        status: event.status,
        modDate: DateTime.now().toLocal().toIso8601String(),
      ),
    );

    response.fold(
      (failure) => emit(
        UsersFailureState(
          type: UsersType.deactivateUser,
          message: failure.toString(),
          users: state.users,
        ),
      ),
      (response) => emit(
        UsersSuccessState(
          type: UsersType.deactivateUser,
          message: response.responseMessage!,
          users: state.users,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onSuspendUser(
    SuspendUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState(type: UsersType.suspendUser, users: state.users));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateUserStatus(
      request: UpdateUserStatusRequestModel(
        token: await _localStorage.getAccessToken() ?? "",
        email: event.email,
        status: event.status,
        modDate: DateTime.now().toLocal().toIso8601String(),
      ),
    );

    response.fold(
      (failure) => emit(
        UsersFailureState(
          type: UsersType.suspendUser,
          message: failure.toString(),
          users: state.users,
        ),
      ),
      (response) => emit(
        UsersSuccessState(
          type: UsersType.suspendUser,
          message: response.responseMessage!,
          users: state.users,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUnsuspendUser(
    UnsuspendUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState(type: UsersType.unsuspendUser, users: state.users));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateUserStatus(
      request: UpdateUserStatusRequestModel(
        token: await _localStorage.getAccessToken() ?? "",
        email: event.email,
        status: event.status,
        modDate: DateTime.now().toLocal().toIso8601String(),
      ),
    );

    response.fold(
      (failure) => emit(
        UsersFailureState(
          type: UsersType.unsuspendUser,
          message: failure.toString(),
          users: state.users,
        ),
      ),
      (response) => emit(
        UsersSuccessState(
          type: UsersType.unsuspendUser,
          message: response.responseMessage!,
          users: state.users,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }
}
