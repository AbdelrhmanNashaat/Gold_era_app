import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import 'widgets/all_transactions_view_body.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
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
      body: const SafeArea(child: AllTransactionsViewBody()),
    );
  }
}
