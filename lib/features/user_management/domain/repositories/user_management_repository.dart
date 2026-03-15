import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/request/delete_user_request_model.dart';
import '../../data/models/request/update_user_status_request_model.dart';
import '../../data/models/response/users_response_model.dart';

abstract class UserManagementRepository {
  Future<Either<String, ApiResponse<List<UsersModel>>>> getAllUsers();
  Future<Either<String, ApiResponse>> deleteUser({
    required DeleteUserRequestModel request,
  });
  Future<Either<String, ApiResponse>> updateUserStatus({
    required UpdateUserStatusRequestModel request,
  });
}
