import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../data/models/request/update_transaction_status_request_model.dart';
import '../../data/models/response/transaction_response_model.dart';

abstract class TransactionRepository {
  Future<Either<String, ApiResponse<List<TransactionModel>>>>
  getAllTransactions();

  Future<Either<String, ApiResponse>> updateTransactionStatus({
    required UpdateTransactionStatusRequestModel request,
  });
}
