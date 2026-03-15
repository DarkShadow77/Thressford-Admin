import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/response/overview_response_model.dart';
import '../../data/models/response/user_profile_response_model.dart';
import '../../domain/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repo;
  DashboardBloc({required this.repo})
    : super(
        DashboardInitialState(
          profile: UserProfile.empty(),
          overview: OverviewModel.empty(),
        ),
      ) {
    on<GetProfileEvent>(_onGetProfile);
    on<GetOverviewEvent>(_onGetOverview);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(profile: event.profile));
    emit(
      DashboardSuccessState(
        type: DashboardType.getProfile,
        message: "Updated Profile Successfully",
        profile: event.profile,
        overview: state.overview,
      ),
    );
  }

  Future<void> _onGetOverview(
    GetOverviewEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      DashboardLoadingState(
        type: DashboardType.getOverview,
        profile: state.profile,
        overview: state.overview,
      ),
    );

    final response = await repo.getOverview();

    response.fold(
      (failure) => emit(
        DashboardFailureState(
          type: DashboardType.getOverview,
          message: failure.toString(),
          profile: state.profile,
          overview: state.overview,
        ),
      ),
      (response) => emit(
        DashboardSuccessState(
          type: DashboardType.getOverview,
          message: response.responseMessage!,
          profile: state.profile,
          overview: response.responseBody!,
        ),
      ),
    );
  }
}
