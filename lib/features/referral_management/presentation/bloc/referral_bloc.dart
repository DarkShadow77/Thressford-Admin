import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/session/session_manager.dart';
import '../../data/models/request/delete_referral_request_model.dart';
import '../../data/models/request/update_commission_request_model.dart';
import '../../data/models/request/update_commission_status_request_model.dart';
import '../../data/models/request/update_enroll_status_request_model.dart';
import '../../data/models/request/update_referral_app_status_request_model.dart';
import '../../data/models/response/referral_response_model.dart';
import '../../domain/repositories/referral_repository.dart';

part 'referral_event.dart';
part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final ReferralRepository repo;

  ReferralBloc({required this.repo})
    : super(ReferralInitialState(referral: [])) {
    on<GetAllReferralEvent>(_onGetAllReferral);
    on<UpdateCommissionEvent>(_onUpdateCommission);
    on<UpdateCommissionStatusEvent>(_onUpdateCommissionStatus);
    on<DeleteReferralEvent>(_onDeleteReferral);
    on<UpdateReferralAppStatusEvent>(_onUpdateReferralAppStatus);
    on<UpdateEnrollStatusEvent>(_onUpdateEnrollStatus);
  }

  Future<void> _onGetAllReferral(
    GetAllReferralEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.getAllReferrals,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.getAllReferrals();

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.getAllReferrals,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) {
        emit(state.copyWith(referral: response.responseBody));
        emit(
          ReferralSuccessState(
            type: ReferralType.getAllReferrals,
            message: response.responseMessage!,
            referral: response.responseBody!,
          ),
        );
      },
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUpdateCommission(
    UpdateCommissionEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.updateCommission,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateCommission(request: event.request);

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.updateCommission,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        ReferralSuccessState(
          type: ReferralType.updateCommission,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUpdateCommissionStatus(
    UpdateCommissionStatusEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.updateCommissionStatus,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateCommissionStatus(request: event.request);

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.updateCommissionStatus,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        ReferralSuccessState(
          type: ReferralType.updateCommissionStatus,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onDeleteReferral(
    DeleteReferralEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.deleteReferral,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.deleteReferral(request: event.request);

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.deleteReferral,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        ReferralSuccessState(
          type: ReferralType.deleteReferral,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUpdateReferralAppStatus(
    UpdateReferralAppStatusEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.updateReferralAppStatus,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateReferralAppStatus(request: event.request);

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.updateReferralAppStatus,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        ReferralSuccessState(
          type: ReferralType.updateReferralAppStatus,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }

  Future<void> _onUpdateEnrollStatus(
    UpdateEnrollStatusEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(
      ReferralLoadingState(
        type: ReferralType.updateEnrollStatus,
        referral: state.referral,
      ),
    );
    SessionManager.instance.notifyLoading(true);

    final response = await repo.updateEnrollStatus(request: event.request);

    response.fold(
      (failure) => emit(
        ReferralFailureState(
          type: ReferralType.updateEnrollStatus,
          message: failure.toString(),
          referral: state.referral,
        ),
      ),
      (response) => emit(
        ReferralSuccessState(
          type: ReferralType.updateEnrollStatus,
          message: response.responseMessage!,
          referral: state.referral,
        ),
      ),
    );
    SessionManager.instance.notifyLoading(false);
  }
}
