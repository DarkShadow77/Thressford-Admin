import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/response/overview_response_model.dart';

abstract class DashboardRepository {
  Future<Either<String, ApiResponse<OverviewModel>>> getOverview();
}
