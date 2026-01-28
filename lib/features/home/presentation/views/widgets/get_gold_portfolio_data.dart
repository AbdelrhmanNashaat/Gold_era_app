import 'dart:developer';
import 'package:calulate_gold_daily_price/core/extensions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../get_gold_ingots_price/data/gold_ingot_model.dart';
import '../../../../get_gold_ingots_price/data/gold_ingots_db.dart';
import '../../../../get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_cubit.dart';
import '../../../../get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_state.dart';
import '../../../../new_transaction/data/gold_database.dart';
import '../../../data/models/item_model.dart';
import 'gold_portfolio_widget.dart';

class GetGoldPortfolioData extends StatefulWidget {
  const GetGoldPortfolioData({super.key});

  @override
  State<GetGoldPortfolioData> createState() => GetGoldPortfolioDataState();
}

class GetGoldPortfolioDataState extends State<GetGoldPortfolioData> {
  void refreshPortfolio() {
    getAllDetails();
  }

  double totalWeight = 0.0;
  double totalPaid = 0.0;
  double totalMechanical = 0.0;
  double currentValue = 0.0;
  double profit = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetGoldIngotsCubit, GetGoldIngotsState>(
      listener: (context, state) {
        if (state is GetGoldIngotsLoaded) {
          addIngotsToDb(products: state.products);
          getAllDetails();
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetGoldIngotsLoading,
          child: GoldPortfolioWidget(
            mechanical: totalMechanical
                .toStringAsFixed(2)
                .localizedNumber(context),
            currentValue: currentValue
                .toStringAsFixed(2)
                .localizedNumber(context),
            weight: totalWeight.toStringAsFixed(2).localizedNumber(context),
            totalPaid: totalPaid.toStringAsFixed(2).localizedNumber(context),
            profit: profit.toStringAsFixed(2).localizedNumber(context),
          ),
        );
      },
    );
  }

  /// Save API ingots to local DB
  Future<void> addIngotsToDb({required List<Product> products}) async {
    final db = GoldIngotsDb.instance;
    await db.clearIngots();

    for (final product in products) {
      await db.addIngot(GoldIngot(title: product.title, price: product.price));
    }
  }

  Future<void> getAllDetails() async {
    final transactions = await GoldDatabase.instance.getAllTransactions();
    final products = await GoldIngotsDb.instance.getAllIngots();

    // Cashback gained when selling (fixed per ingot)
    final Map<double, double> cashbackPerIngot = {
      0.25: 28,
      0.5: 28,
      1: 28,
      2.5: 28,
      5: 28,
      10: 28,
      15.55: 64,
      20: 64,
      25: 64,
      31.10: 63,
      50: 61,
      100: 59,
      500: 0, // Optional, add 500g if needed
    };

    totalWeight = 0;
    totalPaid = 0;
    totalMechanical = 0;
    currentValue = 0;

    // Create a map for quick lookup: grams -> live price
    final Map<double, double> livePriceMap = {};
    for (final product in products) {
      log('Processing product: ${product.title} at price ${product.price} , ');
      final weight = extractWeightFromTitle(product.title);
      final price = _parsePrice(product.price);

      if (weight > 0) {
        livePriceMap[weight] = price;
      }

      log('Ingot: ${product.title}, weight: $weight, price: $price');
    }

    for (final tx in transactions) {
      final weight = tx.grams;
      final paid = tx.buyPrice;

      // Get live gold price from map, fallback to 0.0
      final liveGoldPrice = livePriceMap[weight] ?? 0.0;

      if (liveGoldPrice == 0.0) {
        log('WARNING: No live price found for weight $weight');
      }

      // Cashback received when selling
      final cashback = cashbackPerIngot[weight] ?? 0.0;

      // Current value if sold now
      final currentPrice = liveGoldPrice + cashback;

      // Mechanical loss
      final mechanicalLoss = paid - currentPrice;

      totalWeight += weight;
      totalPaid += paid;
      currentValue += currentPrice;
      totalMechanical += mechanicalLoss;

      log(
        'weight: $weight | paid: $paid | liveGold: $liveGoldPrice | '
        'cashback: $cashback | currentValue: $currentPrice | '
        'mechanicalLoss: $mechanicalLoss',
      );
    }

    profit = currentValue - totalPaid;

    log(
      'TOTAL -> weight: $totalWeight | paid: $totalPaid | '
      'currentValue: $currentValue | mechanicalLoss: $totalMechanical | '
      'profit: $profit',
    );

    setState(() {});
  }

  /// Robust price parser
  double _parsePrice(String price) {
    // Remove anything except digits and dot
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Robust weight extractor for all known titles
  double extractWeightFromTitle(String title) {
    final lower = title.toLowerCase();

    if (lower.contains('quarter')) return 0.25;
    if (lower.contains('0.5') || lower.contains('half')) return 0.5;
    if (lower.contains('1 gram')) return 1;
    if (lower.contains('2.5')) return 2.5;
    if (lower.contains('5')) return 5;
    if (lower.contains('10')) return 10;
    if (lower.contains('15.55')) return 15.55;
    if (lower.contains('20')) return 20;
    if (lower.contains('25')) return 25;
    if (lower.contains('31.10') || lower.contains('ounce')) return 31.10;
    if (lower.contains('50')) return 50;
    if (lower.contains('100')) return 100;
    if (lower.contains('500')) return 500;

    final match = RegExp(r'(\d+(\.\d+)?)').firstMatch(title);
    return match != null ? double.parse(match.group(1)!) : 0.0;
  }
}
