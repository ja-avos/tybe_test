import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tyba_test/src/Orders/models/transaction_model.dart';
import 'package:tyba_test/src/Orders/ui/widgets/transaction_card.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({Key? key}) : super(key: key);

  final valueFormatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          'Transacciones',
          style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 40),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '\$${valueFormatter.format(120000)}',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => TransactionCard(Transaction(
                    name: 'Transacción 1',
                    value: 23450,
                    description: 'Gastos en pruebas',
                    date: DateTime.now(),
                  )),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
