import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_remote_data_source.dart';
import '../models/response/overview_response_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl({required this.dashboardRemoteDataSource});

  @override
  Future<Either<String, ApiResponse<OverviewModel>>> getOverview() async {
    final response = await dashboardRemoteDataSource.getOverview();

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Something went wrong');
    }

    return Right(response);
  }
}
