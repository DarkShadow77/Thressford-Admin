part of 'dashboard_bloc.dart';

enum DashboardType { getProfile, getOverview }

class DashboardState extends Equatable {
  final UserProfile profile;
  final OverviewModel overview;

  const DashboardState({required this.profile, required this.overview});

  DashboardState copyWith({UserProfile? profile, OverviewModel? overview}) {
    return DashboardState(
      profile: profile ?? this.profile,
      overview: overview ?? this.overview,
    );
  }

  @override
  List<Object?> get props => [profile, overview];
}

final class DashboardInitialState extends DashboardState {
  const DashboardInitialState({
    required super.profile,
    required super.overview,
  });

  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState {
  final DashboardType type;
  final String? data;

  const DashboardLoadingState({
    required this.type,
    this.data,
    required super.profile,
    required super.overview,
  });
  @override
  List<Object?> get props => [type, data];
}

class DashboardSuccessState extends DashboardState {
  final String message;
  final DashboardType type;
  final String? data;

  const DashboardSuccessState({
    required this.message,
    required this.type,
    this.data,
    required super.profile,
    required super.overview,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class DashboardFailureState extends DashboardState {
  final String message;
  final DashboardType type;
  final String? data;

  const DashboardFailureState({
    required this.message,
    required this.type,
    this.data,
    required super.profile,
    required super.overview,
  });
  @override
  List<Object?> get props => [type, message, data];
}
