import 'package:dartz/dartz.dart';

import '../../../../core/model/api_model.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../data_sources/transaction_remote_data_source.dart';
import '../models/request/update_transaction_status_request_model.dart';
import '../models/response/transaction_response_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;

  TransactionRepositoryImpl({required this.transactionRemoteDataSource});

  @override
  Future<Either<String, ApiResponse<List<TransactionModel>>>>
  getAllTransactions() async {
    final response = await transactionRemoteDataSource.getAllTransaction();

    if (response.responseSuccessful != true) {
      return Left(
        response.responseMessage ?? 'Failed to Retrieve Transactions',
      );
    }
    return Right(response);
  }

  @override
  Future<Either<String, ApiResponse>> updateTransactionStatus({
    required UpdateTransactionStatusRequestModel request,
  }) async {
    final response = await transactionRemoteDataSource.updateTransactionStatus(
      body: request,
    );

    if (response.responseSuccessful != true) {
      return Left(
        response.responseMessage ?? 'Failed to Update Transaction Status',
      );
    }
    return Right(response);
  }
}
