part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends DashboardEvent {
  final UserProfile profile;
  const GetProfileEvent({required this.profile});
}

class GetOverviewEvent extends DashboardEvent {
  const GetOverviewEvent();
}
