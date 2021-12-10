part of "transaction_cubit.dart";

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final RequestStatus status;
  final String? error;

  const TransactionState({
    this.transactions = const [],
    this.status = RequestStatus.noSubmitted,
    this.error,
  });

  factory TransactionState.initial() => const TransactionState();

  factory TransactionState.loading() =>
      const TransactionState(status: RequestStatus.inProgress);

  factory TransactionState.success(List<Transaction> transactions) =>
      TransactionState(
          transactions: transactions, status: RequestStatus.success);

  factory TransactionState.error(String error) =>
      TransactionState(error: error, status: RequestStatus.failed);

  TransactionStatecopyWith({
    List<Transaction>? transactions,
    RequestStatus? status,
    String? error,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        status,
        error,
      ];
}
