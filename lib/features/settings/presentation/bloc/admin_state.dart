part of 'admin_bloc.dart';

enum AdminType { getAllAdmins, addAdmin, deleteAdmin, updateAdminStatus }

@immutable
class AdminState extends Equatable {
  final List<AdminModel> admins;

  const AdminState({required this.admins});

  AdminState copyWith({List<AdminModel>? admins}) {
    return AdminState(admins: admins ?? this.admins);
  }

  @override
  List<Object?> get props => [admins];
}

final class AdminInitialState extends AdminState {
  const AdminInitialState({required super.admins});

  @override
  List<Object> get props => [];
}

class AdminLoadingState extends AdminState {
  final AdminType type;
  final String? data;

  const AdminLoadingState({
    required this.type,
    this.data,
    required super.admins,
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
    required super.admins,
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
    required super.admins,
  });
  @override
  List<Object?> get props => [type, message, data];
}
