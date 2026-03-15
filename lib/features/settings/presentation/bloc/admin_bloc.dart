import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/request/add_admin_request_model.dart';
import '../../data/models/request/delete_admin_request_model.dart';
import '../../data/models/request/update_admin_status_request_model.dart';
import '../../data/models/response/admin_response_model.dart';
import '../../domain/repositories/admin_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository repo;

  AdminBloc({required this.repo}) : super(AdminInitialState(referral: [])) {
    on<GetAllAdminEvent>(_onGetAllAdmin);
    on<AddAdminEvent>(_onAddAdmin);
    on<DeleteAdminEvent>(_onDeleteAdmin);
    on<UpdateAdminStatusEvent>(_onUpdateAdminStatus);
  }

  Future<void> _onGetAllAdmin(
    GetAllAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(
      AdminLoadingState(type: AdminType.getAllAdmins, referral: state.referral),
    );

    final response = await repo.getAllAdmins();

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.getAllAdmins,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) {
        emit(state.copyWith(referral: response.responseBody));
        emit(
          AdminSuccessState(
            type: AdminType.getAllAdmins,
            message: response.responseMessage!,
            referral: response.responseBody!,
          ),
        );
      },
    );
  }

  Future<void> _onAddAdmin(
    AddAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoadingState(type: AdminType.addAdmin, referral: state.referral));

    final response = await repo.addAdmin(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.addAdmin,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.addAdmin,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
  }

  Future<void> _onDeleteAdmin(
    DeleteAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(
      AdminLoadingState(type: AdminType.deleteAdmin, referral: state.referral),
    );

    final response = await repo.deleteAdmin(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.deleteAdmin,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.deleteAdmin,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
  }

  Future<void> _onUpdateAdminStatus(
    UpdateAdminStatusEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(
      AdminLoadingState(
        type: AdminType.updateAdminStatus,
        referral: state.referral,
      ),
    );

    final response = await repo.updateAdminStatus(request: event.request);

    response.fold(
      (failure) => emit(
        AdminFailureState(
          type: AdminType.updateAdminStatus,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        AdminSuccessState(
          type: AdminType.updateAdminStatus,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
  }
}
