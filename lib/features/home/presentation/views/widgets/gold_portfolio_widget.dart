import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'protfolio_info_item.dart';

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "9,000 EGP",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Current Value",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PortfolioInfoItem(
                icon: FontAwesomeIcons.weightScale,
                label: "Weight",
                value: "150 g",
                iconColor: Colors.amber,
              ),
              PortfolioInfoItem(
                icon: FontAwesomeIcons.receipt,
                label: "Total Paid",
                value: "7,800 EGP",
                iconColor: Colors.blue,
              ),
            ],
          ),

          SizedBox(height: 16),

          PortfolioInfoItem(
            icon: FontAwesomeIcons.chartLine,
            label: "Profit",
            value: "+1,200 EGP",
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
