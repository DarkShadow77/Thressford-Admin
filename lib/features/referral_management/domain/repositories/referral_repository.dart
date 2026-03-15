import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/request/delete_referral_request_model.dart';
import '../../data/models/request/update_commission_request_model.dart';
import '../../data/models/request/update_commission_status_request_model.dart';
import '../../data/models/request/update_enroll_status_request_model.dart';
import '../../data/models/request/update_referral_app_status_request_model.dart';
import '../../data/models/response/referral_response_model.dart';

abstract class ReferralRepository {
  Future<Either<String, ApiResponse<List<ReferralModel>>>> getAllReferrals();
  Future<Either<String, ApiResponse>> updateCommission({
    required UpdateCommissionRequestModel request,
  });
  Future<Either<String, ApiResponse>> updateCommissionStatus({
    required UpdateCommissionStatusRequestModel request,
  });
  Future<Either<String, ApiResponse>> deleteReferral({
    required DeleteReferralRequestModel request,
  });
  Future<Either<String, ApiResponse>> updateReferralAppStatus({
    required UpdateReferralAppStatusRequestModel request,
  });
  Future<Either<String, ApiResponse>> updateEnrollStatus({
    required UpdateEnrollStatusRequestModel request,
  });
}
