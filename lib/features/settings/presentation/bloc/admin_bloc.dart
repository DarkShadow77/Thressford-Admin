import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/session/session_manager.dart';
import '../../data/models/request/add_admin_request_model.dart';
import '../../data/models/request/delete_admin_request_model.dart';
import '../../data/models/request/update_admin_status_request_model.dart';
import '../../data/models/response/admin_response_model.dart';
import '../../domain/repositories/admin_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository repo;

  AdminBloc({required this.repo}) : super(AdminInitialState(admins: [])) {
    on<GetAllAdminEvent>(_onGetAllAdmin);
    on<AddAdminEvent>(_onAddAdmin);
    on<DeleteAdminEvent>(_onDeleteAdmin);
    on<UpdateAdminStatusEvent>(_onUpdateAdminStatus);
  }

  Future<void> _onGetAllAdmin(
    GetAllAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoadingState(type: AdminType.getAllAdmins, admins: state.admins));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.getAllAdmins();

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.getAllAdmins,
          message: failure.toString(),
          admins: state.admins,
        ),
      ),
      (response) {
        emit(state.copyWith(admins: response.responseBody));
        emit(
          AdminSuccessState(
            type: AdminType.getAllAdmins,
            message: response.responseMessage!,
            admins: response.responseBody!,
          ),
        );
      },
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onAddAdmin(
    AddAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoadingState(type: AdminType.addAdmin, admins: state.admins));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.addAdmin(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.addAdmin,
          message: failure.toString(),
          admins: state.admins,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.addAdmin,
          message: response.responseMessage!,
          admins: state.admins,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onDeleteAdmin(
    DeleteAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoadingState(type: AdminType.deleteAdmin, admins: state.admins));
    SessionManager.instance.notifyLoading(true);

    final response = await repo.deleteAdmin(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.deleteAdmin,
          message: failure.toString(),
          admins: state.admins,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.deleteAdmin,
          message: response.responseMessage!,
          admins: state.admins,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUpdateAdminStatus(
    UpdateAdminStatusEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(
      AdminLoadingState(
        type: AdminType.updateAdminStatus,
        admins: state.admins,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateAdminStatus(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.updateAdminStatus,
          message: failure.toString(),
          admins: state.admins,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.updateAdminStatus,
          message: response.responseMessage!,
          admins: state.admins,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }
}
