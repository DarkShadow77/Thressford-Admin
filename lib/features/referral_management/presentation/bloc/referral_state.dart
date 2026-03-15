part of 'referral_bloc.dart';

enum ReferralType {
  getAllReferrals,
  updateCommission,
  updateCommissionStatus,
  deleteReferral,
  updateReferralAppStatus,
  updateEnrollStatus,
}

@immutable
class ReferralState extends Equatable {
  final List<ReferralModel> referral;

  const ReferralState({required this.referral});

  ReferralState copyWith({List<ReferralModel>? referral}) {
    return ReferralState(referral: referral ?? this.referral);
  }

  @override
  List<Object?> get props => [referral];
}

final class ReferralInitialState extends ReferralState {
  const ReferralInitialState({required super.referral});

  @override
  List<Object> get props => [];
}

class ReferralLoadingState extends ReferralState {
  final ReferralType type;
  final String? data;

  const ReferralLoadingState({
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [type, data];
}

class ReferralSuccessState extends ReferralState {
  final String message;
  final ReferralType type;
  final String? data;

  const ReferralSuccessState({
    required this.message,
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class ReferralFailureState extends ReferralState {
  final String message;
  final ReferralType type;
  final String? data;

  const ReferralFailureState({
    required this.message,
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [type, message, data];
}
