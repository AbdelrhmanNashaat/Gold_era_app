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
  State<LatestLastTransactions> createState() => _LatestLastTransactionsState();
}

class _LatestLastTransactionsState extends State<LatestLastTransactions> {
  List<TransactionModel> transactions = [];
  bool isLoading = true;

  // Fake transactions for skeleton loading
  final List<TransactionModel> fakeTransactions = List.generate(
    3,
    (_) => TransactionModel(
      id: '0',
      money: '2253.66',
      weight: '0.25',
      date: '19 Aug, 2026',
    ),
  );

  @override
  void initState() {
    super.initState();
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
        itemCount: displayTransactions.length,
        itemBuilder: (context, index) {
          return LastTransactionWidget(
            transactions: displayTransactions[index],
          );
        },
      ),
    );
  }

  Future<void> fetchTransactions() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate loading
    List<GoldTransaction> goldIngots = await GoldDatabase.instance
        .getAllTransactions();

    setState(() {
      transactions = goldIngots
          .map(
            (ingot) => TransactionModel(
              id: ingot.id.toString(),
              money: ingot.buyPrice.toString(),
              weight: ingot.weight,
              date: ingot.date,
            ),
          )
          .toList();
      isLoading = false;
    });
  }
}
