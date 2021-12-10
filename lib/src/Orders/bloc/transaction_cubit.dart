import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tyba_test/src/Orders/models/transaction_model.dart';
import 'package:tyba_test/src/Orders/repository/transaction_repository.dart';
import 'package:tyba_test/src/utils/request_status.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repository;

  TransactionCubit(this.repository) : super(TransactionState.initial());

  void getTransactions() async {
    emit(TransactionState.loading());
    try {
      final transactions = await repository.getTransactions();
      emit(TransactionState.success(transactions));
    } catch (e) {
      emit(TransactionState.error(e.toString()));
    }
  }
}
