import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/transaction_model.dart';
import 'widgets/all_transactions_view_body.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({super.key, required this.transactions});
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          S.of(context).AllTransactions,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AllTransactionsViewBody(transactions: transactions),
      ),
    );
  }
}
