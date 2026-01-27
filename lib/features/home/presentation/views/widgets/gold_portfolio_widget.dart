import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../generated/l10n.dart';
import 'portfolio_info_item.dart';

class GoldPortfolioWidget extends StatelessWidget {
  const GoldPortfolioWidget({super.key});

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
                  "9,000 ${S.of(context).EGP}",
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
                value: "150 ${S.of(context).g}",
                iconColor: Colors.amber,
              ),
              PortfolioInfoItem(
                icon: FontAwesomeIcons.receipt,
                label: S.of(context).TotalPaid,
                value: "7,800 ${S.of(context).EGP}",
                iconColor: Colors.blue,
              ),
            ],
          ),

          const SizedBox(height: 16),

          PortfolioInfoItem(
            icon: FontAwesomeIcons.chartLine,
            label: S.of(context).Profit,
            value: "+1,200 ${S.of(context).EGP}",
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
