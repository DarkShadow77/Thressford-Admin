part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
  @override
  List<Object?> get props => [];
}

class GetAllTransactionEvent extends TransactionEvent {
  const GetAllTransactionEvent();
}

class UpdateTransactionStatusEvent extends TransactionEvent {
  final UpdateTransactionStatusRequestModel request;

  const UpdateTransactionStatusEvent({required this.request});
  @override
  List<Object?> get props => [request];
}
