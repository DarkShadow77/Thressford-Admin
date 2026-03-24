part of 'transaction_bloc.dart';

enum TransactionType { getAllTransactions, updateTransactionStatus }

@immutable
class TransactionState extends Equatable {
  final List<TransactionModel> transactions;

  const TransactionState({required this.transactions});

  TransactionState copyWith({List<TransactionModel>? transactions}) {
    return TransactionState(transactions: transactions ?? this.transactions);
  }

  @override
  List<Object?> get props => [transactions];
}

final class TransactionInitialState extends TransactionState {
  const TransactionInitialState({required super.transactions});

  @override
  List<Object> get props => [];
}

class TransactionLoadingState extends TransactionState {
  final TransactionType type;
  final String? data;

  const TransactionLoadingState({
    required this.type,
    this.data,
    required super.transactions,
  });
  @override
  List<Object?> get props => [type, data];
}

class TransactionSuccessState extends TransactionState {
  final String message;
  final TransactionType type;
  final String? data;

  const TransactionSuccessState({
    required this.message,
    required this.type,
    this.data,
    required super.transactions,
  });
  @override
  List<Object?> get props => [message, type, data];
}

class TransactionFailureState extends TransactionState {
  final String message;
  final TransactionType type;
  final String? data;

  const TransactionFailureState({
    required this.message,
    required this.type,
    this.data,
    required super.transactions,
  });
  @override
  List<Object?> get props => [type, message, data];
}
