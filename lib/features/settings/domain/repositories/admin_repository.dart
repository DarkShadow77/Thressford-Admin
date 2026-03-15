import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/request/add_admin_request_model.dart';
import '../../data/models/request/delete_admin_request_model.dart';
import '../../data/models/request/update_admin_status_request_model.dart';
import '../../data/models/response/admin_response_model.dart';

abstract class AdminRepository {
  Future<Either<String, ApiResponse<List<AdminModel>>>> getAllAdmins();

  Future<Either<String, ApiResponse>> addAdmin({
    required AddAdminRequestModel request,
  });
  Future<Either<String, ApiResponse>> deleteAdmin({
    required DeleteAdminRequestModel request,
  });
  Future<Either<String, ApiResponse>> updateAdminStatus({
    required UpdateAdminStatusRequestModel request,
  });
}
