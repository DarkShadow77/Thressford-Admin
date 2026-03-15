import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../dashboard/data/models/response/user_profile_response_model.dart';
import '../models/request/login_request_model.dart';

class AuthRemoteDataSource {
  Future<ApiResponse<UserProfile>> login({
    required LoginRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      AuthUrl.login,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
      transform: (data) => UserProfile.fromJson(data),
    );
    return response;
  }
}
