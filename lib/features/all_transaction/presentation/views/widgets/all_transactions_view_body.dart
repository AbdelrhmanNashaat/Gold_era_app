import 'package:calulate_gold_daily_price/core/extensions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/views/widgets/last_transaction_widget.dart';
import '../../../../new_transaction/data/gold_database.dart';
import '../../../../new_transaction/data/models/gold_model.dart';
import '../../../data/models/transaction_model.dart';

class AllTransactionsViewBody extends StatefulWidget {
  const AllTransactionsViewBody({super.key});

  @override
  State<AllTransactionsViewBody> createState() =>
      _AllTransactionsViewBodyState();
}

class _AllTransactionsViewBodyState extends State<AllTransactionsViewBody> {
  List<TransactionModel> transactions = [];
  bool isLoading = true;

  final List<TransactionModel> fakeTransactions = List.generate(
    8,
    (_) => TransactionModel(
      id: '0',
      money: '2263.336',
      weight: '0.25',
      date: '19 jan 2026',
    ),
  );

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final List<TransactionModel> displayTransactions = isLoading
        ? fakeTransactions
        : transactions;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Skeletonizer(
        enabled: isLoading,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    '${S.of(context).TotalTransactions}: ${displayTransactions.length}'
                        .localizedNumber(context),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            displayTransactions.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        S.of(context).NoTransactionsYet,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : SliverList.builder(
                    itemCount: displayTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = displayTransactions[index];
                      return LastTransactionWidget(transactions: transaction);
                    },
                  ),
          ],
        ),
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
