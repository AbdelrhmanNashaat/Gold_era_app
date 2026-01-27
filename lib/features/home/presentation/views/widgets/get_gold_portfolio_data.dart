import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../get_gold_ingots_price/data/gold_ingot_model.dart';
import '../../../../get_gold_ingots_price/data/gold_ingots_db.dart';
import '../../../../get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_cubit.dart';
import '../../../../get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_state.dart';
import '../../../data/models/item_model.dart';
import 'gold_portfolio_widget.dart';

class GetGoldPortfolioData extends StatelessWidget {
  const GetGoldPortfolioData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetGoldIngotsCubit, GetGoldIngotsState>(
      listener: (context, state) {
        if (state is GetGoldIngotsLoaded) {
          addIngotsToDb(products: state.products);
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetGoldIngotsLoading ? true : false,
          child: const GoldPortfolioWidget(
            currentValue: "9000",
            weight: "150",
            totalPaid: "8500",
            profit: "500",
          ),
        );
      },
    );
  }

  Future<void> addIngotsToDb({required List<Product> products}) async {
    final db = GoldIngotsDb.instance;
    await db.clearIngots();
    for (var product in products) {
      await db.addIngot(GoldIngot(title: product.title, price: product.price));
    }
  }
}
