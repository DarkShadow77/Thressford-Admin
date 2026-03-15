import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../domain/repositories/referral_repository.dart';
import '../data_sources/referral_remote_data_source.dart';
import '../models/request/delete_referral_request_model.dart';
import '../models/request/update_commission_request_model.dart';
import '../models/request/update_commission_status_request_model.dart';
import '../models/request/update_enroll_status_request_model.dart';
import '../models/request/update_referral_app_status_request_model.dart';
import '../models/response/referral_response_model.dart';

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralRemoteDataSource referralRemoteDataSource;

  ReferralRepositoryImpl({required this.referralRemoteDataSource});

  @override
  Future<Either<String, ApiResponse<List<ReferralModel>>>>
  getAllReferrals() async {
    final response = await referralRemoteDataSource.getAllReferrals();

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Retrieve Referrals');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateCommission({
    required UpdateCommissionRequestModel request,
  }) async {
    final response = await referralRemoteDataSource.updateCommission(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Update Commission');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateCommissionStatus({
    required UpdateCommissionStatusRequestModel request,
  }) async {
    final response = await referralRemoteDataSource.updateCommissionStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(
        response.responseMessage ?? 'Failed to Update Commission Status',
      );
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> deleteReferral({
    required DeleteReferralRequestModel request,
  }) async {
    final response = await referralRemoteDataSource.deleteReferral(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Delete Referral');
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateReferralAppStatus({
    required UpdateReferralAppStatusRequestModel request,
  }) async {
    final response = await referralRemoteDataSource.updateReferralAppStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(
        response.responseMessage ?? 'Failed to Update Referral App Status',
      );
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateEnrollStatus({
    required UpdateEnrollStatusRequestModel request,
  }) async {
    final response = await referralRemoteDataSource.updateEnrollStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(response.responseMessage ?? 'Failed to Update Enroll Status');
    }
    return Right(response);
  }
}
