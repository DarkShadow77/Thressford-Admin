/*import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' hide MultipartFile;
import 'package:objectid/objectid.dart';

import '../../../../core/model/api_model.dart';
import '../../../../core/utils/local_storage.dart';
import '../models/request/login_request_model.dart';*/
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  /*@override
  Future<Either<String, ApiResponse>> login({
    required LoginRequestModel request,
  }) async {
    var body = FormData.fromMap(request.toMap());
    final response = await authRemoteDataSource.login(body: body);

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Login Failed');
    }
    LocalStorageHelper().setAccessToken(
      accessToken: response.responseBody?.jwt ?? "",
    );
    LocalStorageHelper().setApiKey(apiKey: response.responseBody?.jwt ?? "");
    return Right(response);
  }*/
}
