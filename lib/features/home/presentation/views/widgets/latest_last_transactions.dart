import 'package:flutter/material.dart';

import '../../../../all_transaction/data/models/transaction_model.dart';
import 'last_transaction_widget.dart';

class LatestLastTransactions extends StatelessWidget {
  const LatestLastTransactions({super.key, required this.transactions});
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.reversed.take(3).length,
      itemBuilder: (context, index) {
        return LastTransactionWidget(transactions: transactions[index]);
      },
    );
  }
}
