import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../all_transaction/data/models/transaction_model.dart';
import '../../../../new_transaction/data/gold_database.dart';
import '../../../../new_transaction/data/models/gold_model.dart';
import 'last_transaction_widget.dart';

class LatestLastTransactions extends StatefulWidget {
  const LatestLastTransactions({super.key});

  @override
  State<LatestLastTransactions> createState() => LatestLastTransactionsState();
}

class LatestLastTransactionsState extends State<LatestLastTransactions> {
  List<TransactionModel> transactions = [];
  bool isLoading = true;

  final List<TransactionModel> fakeTransactions = List.generate(
    3,
    (_) => TransactionModel(
      id: '0',
      money: '2263.336',
      weight: '0.25',
      date: '19 Jan 2026',
    ),
  );

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    List<GoldTransaction> goldIngots = await GoldDatabase.instance
        .getAllTransactions();

    setState(() {
      transactions = goldIngots
          .map(
            (ingot) => TransactionModel(
              id: ingot.id.toString(),
              money: ingot.buyPrice.toString(),
              weight: ingot.grams.toString(),
              date: ingot.date,
            ),
          )
          .toList();
      isLoading = false;
    });
  }

  // Public method to refresh from parent
  void refreshTransactions() {
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final displayTransactions = isLoading
        ? fakeTransactions
        : transactions.reversed.take(3).toList();

    if (!isLoading && displayTransactions.isEmpty) {
      return Center(
        child: Text(
          S.of(context).NoTransactionsYet,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isLoading
            ? fakeTransactions.length
            : transactions.reversed.take(3).length,
        itemBuilder: (context, index) {
          final transaction = isLoading
              ? fakeTransactions[index]
              : transactions.reversed.take(3).toList()[index];
          return LastTransactionWidget(
            needDelete: false,
            transactions: transaction,
            onDelete: isLoading
                ? null
                : () async {
                    await GoldDatabase.instance.deleteTransaction(
                      int.parse(transaction.id),
                    );
                    setState(() => transactions.remove(transaction));
                  },
          );
        },
      ),
    );
  }
}
