import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';
import '../models/request/delete_user_request_model.dart';
import '../models/request/update_user_status_request_model.dart';
import '../models/response/users_response_model.dart';

class UserManagementRemoteDataSource {
  Future<ApiResponse<List<UsersModel>>> getAllUsers() async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      UserUrl.getAllUser,
      {"token": accessToken},
      apiKey: apikey,
      accessToken: accessToken,
      transform: (dynamic res) {
        if (res is List) {
          return res.map((e) => UsersModel.fromJson(e)).toList();
        } else if (res is String) {
          return <UsersModel>[];
        } else {
          // Handle error or unexpected response format
          throw const FormatException('Invalid response format');
        }
      },
    );
    return response;
  }

  Future<ApiResponse> deleteUser({required DeleteUserRequestModel body}) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      UserUrl.deleteUser,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> updateUserStatus({
    required UpdateUserStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      UserUrl.updateUserStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }
}
