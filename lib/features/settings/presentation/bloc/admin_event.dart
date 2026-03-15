part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class GetAllAdminEvent extends AdminEvent {
  const GetAllAdminEvent();
}

class AddAdminEvent extends AdminEvent {
  final AddAdminRequestModel request;

  const AddAdminEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class DeleteAdminEvent extends AdminEvent {
  final DeleteAdminRequestModel request;

  const DeleteAdminEvent({required this.request});
  @override
  List<Object?> get props => [request];
}

class UpdateAdminStatusEvent extends AdminEvent {
  final UpdateAdminStatusRequestModel request;

  const UpdateAdminStatusEvent({required this.request});
  @override
  List<Object?> get props => [request];
}
