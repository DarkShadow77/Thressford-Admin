part of 'referral_bloc.dart';

@immutable
sealed class ReferralEvent extends Equatable {
  const ReferralEvent();
  @override
  List<Object?> get props => [];
}

class GetAllReferralEvent extends ReferralEvent {
  const GetAllReferralEvent();
}

class UpdateCommissionEvent extends ReferralEvent {
  final UpdateCommissionRequestModel request;

  const UpdateCommissionEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class UpdateCommissionStatusEvent extends ReferralEvent {
  final UpdateCommissionStatusRequestModel request;

  const UpdateCommissionStatusEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class DeleteReferralEvent extends ReferralEvent {
  final DeleteReferralRequestModel request;

  const DeleteReferralEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class UpdateReferralAppStatusEvent extends ReferralEvent {
  final UpdateReferralAppStatusRequestModel request;

  const UpdateReferralAppStatusEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class UpdateEnrollStatusEvent extends ReferralEvent {
  final UpdateEnrollStatusRequestModel request;

  const UpdateEnrollStatusEvent({required this.request});
  @override
  List<Object?> get props => [request];
}
