part of 'admin_bloc.dart';

enum AdminType { getAllAdmins, addAdmin, deleteAdmin, updateAdminStatus }

@immutable
class AdminState extends Equatable {
  final List<AdminModel> referral;

  const AdminState({required this.referral});

  AdminState copyWith({List<AdminModel>? referral}) {
    return AdminState(referral: referral ?? this.referral);
  }

  @override
  List<Object?> get props => [referral];
}

final class AdminInitialState extends AdminState {
  const AdminInitialState({required super.referral});

  @override
  List<Object> get props => [];
}

class AdminLoadingState extends AdminState {
  final AdminType type;
  final String? data;

  const AdminLoadingState({
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [type, data];
}

class AdminSuccessState extends AdminState {
  final String message;
  final AdminType type;
  final String? data;

  const AdminSuccessState({
    required this.message,
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class AdminFailureState extends AdminState {
  final String message;
  final AdminType type;
  final String? data;

  const AdminFailureState({
    required this.message,
    required this.type,
    this.data,
    required super.referral,
  });
  @override
  List<Object?> get props => [type, message, data];
}
