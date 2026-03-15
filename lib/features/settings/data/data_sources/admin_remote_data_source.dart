import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';
import '../models/request/add_admin_request_model.dart';
import '../models/request/delete_admin_request_model.dart';
import '../models/request/update_admin_status_request_model.dart';
import '../models/response/admin_response_model.dart';

class AdminRemoteDataSource {
  Future<ApiResponse<List<AdminModel>>> getAllAdmin() async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      AdminUrl.getAllAdmin,
      {"token": accessToken},
      apiKey: apikey,
      accessToken: accessToken,
      transform: (dynamic res) {
        if (res is List) {
          return res.map((e) => AdminModel.fromJson(e)).toList();
        } else if (res is String) {
          return <AdminModel>[];
        } else {
          // Handle error or unexpected response format
          throw const FormatException('Invalid response format');
        }
      },
    );
    return response;
  }

  Future<ApiResponse> addAdmin({required AddAdminRequestModel body}) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      AdminUrl.addAdmin,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> updateAdminStatus({
    required UpdateAdminStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      AdminUrl.updateAdminStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> deleteAdmin({
    required DeleteAdminRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      AdminUrl.deleteAdmin,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }
}
