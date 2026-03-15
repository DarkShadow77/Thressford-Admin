import 'package:thressford_admin/features/dashboard/data/models/response/overview_response_model.dart';

import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';

class DashboardRemoteDataSource {
  Future<ApiResponse<OverviewModel>> getOverview() async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      DashboardUrl.getOverview,
      {"token": accessToken},
      apiKey: apikey,
      accessToken: accessToken,
      transform: (data) => OverviewModel.fromJson(data),
    );
    return response;
  }
}
