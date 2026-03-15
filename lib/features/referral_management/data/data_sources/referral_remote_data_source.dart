import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';
import '../models/request/delete_referral_request_model.dart';
import '../models/request/update_commission_request_model.dart';
import '../models/request/update_commission_status_request_model.dart';
import '../models/request/update_enroll_status_request_model.dart';
import '../models/request/update_referral_app_status_request_model.dart';
import '../models/response/referral_response_model.dart';

class ReferralRemoteDataSource {
  Future<ApiResponse<List<ReferralModel>>> getAllReferrals() async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      ReferralUrl.getAllReferrals,
      {"token": accessToken},
      apiKey: apikey,
      accessToken: accessToken,
      transform: (dynamic res) {
        if (res is List) {
          return res.map((e) => ReferralModel.fromJson(e)).toList();
        } else if (res is String) {
          return <ReferralModel>[];
        } else {
          // Handle error or unexpected response format
          throw const FormatException('Invalid response format');
        }
      },
    );
    return response;
  }

  Future<ApiResponse> updateCommission({
    required UpdateCommissionRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      ReferralUrl.updateCommission,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> updateCommissionStatus({
    required UpdateCommissionStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      ReferralUrl.updateCommissionStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> deleteReferral({
    required DeleteReferralRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      ReferralUrl.deleteReferral,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> updateReferralAppStatus({
    required UpdateReferralAppStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      ReferralUrl.updateReferralAppStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }

  Future<ApiResponse> updateEnrollStatus({
    required UpdateEnrollStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      ReferralUrl.updateEnrollStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }
}
