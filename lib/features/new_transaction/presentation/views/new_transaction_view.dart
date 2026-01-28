import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'widgets/new_transaction_view_body.dart';

class NewTransactionView extends StatelessWidget {
  const NewTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          S.of(context).NewTransaction,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(child: NewTransactionViewBody()),
    );
  }
}
