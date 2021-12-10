import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tyba_test/src/Orders/bloc/transaction_cubit.dart';
import 'package:tyba_test/src/Orders/models/transaction_model.dart';
import 'package:tyba_test/src/Orders/ui/widgets/transaction_card.dart';
import 'package:tyba_test/src/utils/request_status.dart';
import 'package:tyba_test/src/utils/widgets/loading.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({Key? key}) : super(key: key);

  final valueFormatter = NumberFormat.decimalPattern();

  Widget buildTransactionList(context, List<Transaction> transactions) {
    final total = transactions.fold(
        0, (num total, Transaction transaction) => total + transaction.value);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '\$${valueFormatter.format(total)}',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) =>
                  TransactionCard(transactions[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionCubit>(context).getTransactions();
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Transacciones',
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 40),
          ),
          const SizedBox(height: 40),
          if (state.status == RequestStatus.success)
            buildTransactionList(context, state.transactions),
          if (state.status == RequestStatus.inProgress)
            const Expanded(child: Loading()),
          if (state.status == RequestStatus.failed)
            const Expanded(
              child: Center(
                child: Text('Error al cargar las transacciones'),
              ),
            ),
        ],
      );
    });
  }
}
