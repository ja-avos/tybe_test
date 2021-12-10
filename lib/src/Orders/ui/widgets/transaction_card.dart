import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyba_test/src/Orders/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final valueFormatter = NumberFormat.decimalPattern();

  TransactionCard(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction.name,
                        style: Theme.of(context).textTheme.headline6),
                    if (transaction.description != null)
                      Text(transaction.description!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1),
                  ]),
            ),
            Text(
              '\$${valueFormatter.format(transaction.value)}',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: transaction.value >= 0 ? Colors.green : Colors.red,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
