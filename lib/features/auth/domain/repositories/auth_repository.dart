import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/request/login_request_model.dart';

abstract class AuthRepository {
  Future<Either<String, ApiResponse>> login({
    required LoginRequestModel request,
  });
}
