import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../../../core/utils/local_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/request/change_password_request_model.dart';
import '../models/request/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<String, ApiResponse>> login({
    required LoginRequestModel request,
  }) async {
    final response = await authRemoteDataSource.login(body: request);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Login Failed');
    }
    LocalStorageHelper().setAccessToken(
      accessToken: response.responseBody?.token ?? "",
    );
    LocalStorageHelper().setApiKey(apiKey: response.responseBody?.token ?? "");
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> changePassword({
    required ChangePasswordRequestModel request,
  }) async {
    final response = await authRemoteDataSource.changePassword(body: request);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'ChangePassword Failed');
    }
    LocalStorageHelper().setAccessToken(
      accessToken: response.responseBody?.token ?? "",
    );
    LocalStorageHelper().setApiKey(apiKey: response.responseBody?.token ?? "");
    return Right(response);
  }
}
