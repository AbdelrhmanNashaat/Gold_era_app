import 'package:calulate_gold_daily_price/core/extentions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../generated/l10n.dart';
import 'portfolio_info_item.dart';

class GoldPortfolioWidget extends StatelessWidget {
  const GoldPortfolioWidget({
    super.key,
    required this.currentValue,
    required this.weight,
    required this.totalPaid,
    required this.profit,
  });
  final String currentValue;
  final String weight;
  final String totalPaid;
  final String profit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "$currentValue ${S.of(context).EGP}".localizedNumber(context),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).CurrentValue,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PortfolioInfoItem(
                icon: FontAwesomeIcons.weightScale,
                label: S.of(context).Weight,
                value: "$weight ${S.of(context).g}".localizedNumber(context),
                iconColor: Colors.amber,
              ),
              PortfolioInfoItem(
                icon: FontAwesomeIcons.receipt,
                label: S.of(context).TotalPaid,
                value: "$totalPaid ${S.of(context).EGP}".localizedNumber(
                  context,
                ),
                iconColor: Colors.blue,
              ),
            ],
          ),

          const SizedBox(height: 16),

          PortfolioInfoItem(
            icon: FontAwesomeIcons.chartLine,
            label: S.of(context).Profit,
            value: "$profit ${S.of(context).EGP}".localizedNumber(context),
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
