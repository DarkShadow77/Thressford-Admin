import '../../../../core/constants/url_path.dart';
import '../../../../core/model/api_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/local_storage.dart';
import '../models/request/update_transaction_status_request_model.dart';
import '../models/response/transaction_response_model.dart';

class TransactionRemoteDataSource {
  Future<ApiResponse<List<TransactionModel>>> getAllTransaction() async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequestHandler(
      TransactionUrl.getAllTransaction,
      {"token": accessToken},
      apiKey: apikey,
      accessToken: accessToken,
      transform: (dynamic res) {
        if (res is List) {
          return res.map((e) => TransactionModel.fromJson(e)).toList();
        } else if (res is String) {
          return <TransactionModel>[];
        } else {
          // Handle error or unexpected response format
          throw const FormatException('Invalid response format');
        }
      },
    );
    return response;
  }

  Future<ApiResponse> updateTransactionStatus({
    required UpdateTransactionStatusRequestModel body,
  }) async {
    final storage = LocalStorageHelper();
    String apikey = await storage.getApiKey() ?? "";
    String accessToken = await storage.getAccessToken() ?? "";
    final response = ApiService.instance!.postRequest(
      TransactionUrl.updateTransactionStatus,
      body.toJson(),
      apiKey: apikey,
      accessToken: accessToken,
    );
    return response;
  }
}
