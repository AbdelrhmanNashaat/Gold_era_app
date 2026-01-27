import 'package:calulate_gold_daily_price/core/extentions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../generated/l10n.dart';
import '../../../../all_transaction/data/models/transaction_model.dart';
import 'transaction_info.dart';

class LastTransactionWidget extends StatelessWidget {
  const LastTransactionWidget({super.key, required this.transactions});
  final TransactionModel transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Money
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.moneyBillWave,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                "${transactions.money} ${S.of(context).EGP}".localizedNumber(
                  context,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TransactionInfo(
                icon: FontAwesomeIcons.weightScale,
                text: "${transactions.weight} ${S.of(context).g}"
                    .localizedNumber(context),
              ),
              TransactionInfo(
                icon: FontAwesomeIcons.calendarDays,
                text: transactions.date,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
