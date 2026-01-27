import 'package:calulate_gold_daily_price/features/get_gold_ingots_price/presentation/views/get_gold_ingots_price_view.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import 'home_action_card.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3 / 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeActionCard(
          icon: Icons.monetization_on_outlined,
          title: S.of(context).GoldIngots,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GetGoldIngotsPriceView(),
              ),
            );
          },
        ),
        HomeActionCard(
          icon: Icons.add_circle_outline,
          title: S.of(context).NewTransaction,
          onTap: () {},
        ),
      ],
    );
  }
}
