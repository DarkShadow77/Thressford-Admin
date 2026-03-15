import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../domain/repositories/admin_repository.dart';
import '../data_sources/admin_remote_data_source.dart';
import '../models/request/add_admin_request_model.dart';
import '../models/request/delete_admin_request_model.dart';
import '../models/request/update_admin_status_request_model.dart';
import '../models/response/admin_response_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;

  AdminRepositoryImpl({required this.adminRemoteDataSource});

  @override
  Future<Either<String, ApiResponse<List<AdminModel>>>> getAllAdmins() async {
    final response = await adminRemoteDataSource.getAllAdmin();

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Retrieve Admins');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> addAdmin({
    required AddAdminRequestModel request,
  }) async {
    final response = await adminRemoteDataSource.addAdmin(body: request);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Add Admin');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> deleteAdmin({
    required DeleteAdminRequestModel request,
  }) async {
    final response = await adminRemoteDataSource.deleteAdmin(body: request);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Delete Admin');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateAdminStatus({
    required UpdateAdminStatusRequestModel request,
  }) async {
    final response = await adminRemoteDataSource.updateAdminStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Update Admin Status');
    }
    return Right(response);
  }
}
