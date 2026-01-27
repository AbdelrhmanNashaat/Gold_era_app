import 'package:calulate_gold_daily_price/core/extentions/number_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/views/widgets/last_transaction_widget.dart';
import '../../../data/models/transaction_model.dart';

class AllTransactionsViewBody extends StatelessWidget {
  const AllTransactionsViewBody({super.key, required this.transactions});
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 16),
                Text(
                  '${S.of(context).TotalTransactions}: ${transactions.length}'
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
          SliverList.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return LastTransactionWidget(transactions: transaction);
            },
          ),
        ],
      ),
    );
  }
}
