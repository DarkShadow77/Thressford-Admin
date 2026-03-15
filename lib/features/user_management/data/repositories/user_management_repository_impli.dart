import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../domain/repositories/user_management_repository.dart';
import '../data_sources/user_management_remote_data_source.dart';
import '../models/request/delete_user_request_model.dart';
import '../models/request/update_user_status_request_model.dart';
import '../models/response/users_response_model.dart';

class UserManagementRepositoryImpl implements UserManagementRepository {
  final UserManagementRemoteDataSource usersRemoteDataSource;

  UserManagementRepositoryImpl({required this.usersRemoteDataSource});

  @override
  Future<Either<String, ApiResponse<List<UsersModel>>>> getAllUsers() async {
    final response = await usersRemoteDataSource.getAllUsers();

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Retrieve Users');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> deleteUser({
    required DeleteUserRequestModel request,
  }) async {
    final response = await usersRemoteDataSource.deleteUser(body: request);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Delete User');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateUserStatus({
    required UpdateUserStatusRequestModel request,
  }) async {
    final response = await usersRemoteDataSource.updateUserStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Update User Status');
    }
    return Right(response);
  }
}
