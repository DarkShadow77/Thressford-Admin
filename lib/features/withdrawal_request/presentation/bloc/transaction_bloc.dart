import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/request/update_transaction_status_request_model.dart';
import '../../data/models/response/transaction_response_model.dart';
import '../../domain/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repo;

  TransactionBloc({required this.repo})
    : super(TransactionInitialState(transactions: [])) {
    on<GetAllTransactionEvent>(_onGetAllTransaction);
    on<UpdateTransactionStatusEvent>(_onUpdateTransactionStatus);
  }

  Future<void> _onGetAllTransaction(
    GetAllTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      TransactionLoadingState(
        type: TransactionType.getAllTransactions,
        transactions: state.transactions,
      ),
    );

    final response = await repo.getAllTransactions();

    response.fold(
      (failure) => emit(
        TransactionFailureState(
          type: TransactionType.getAllTransactions,
          message: failure.toString(),
          transactions: state.transactions,
        ),
      ),
      (response) {
        emit(state.copyWith(transactions: response.responseBody));
        emit(
          TransactionSuccessState(
            type: TransactionType.getAllTransactions,
            message: response.responseMessage!,
            transactions: response.responseBody!,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateTransactionStatus(
    UpdateTransactionStatusEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      TransactionLoadingState(
        type: TransactionType.updateTransactionStatus,
        transactions: state.transactions,
      ),
    );

    final response = await repo.updateTransactionStatus(request: event.request);

    response.fold(
      (failure) => emit(
        TransactionFailureState(
          type: TransactionType.updateTransactionStatus,
          message: failure.toString(),
          transactions: state.transactions,
        ),
      ),
      (response) => emit(
        TransactionSuccessState(
          type: TransactionType.updateTransactionStatus,
          message: response.responseMessage!,
          transactions: state.transactions,
        ),
      ),
    );
  }
}
