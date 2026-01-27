import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import 'gold_portfolio_widget.dart';
import 'language_toggle.dart';
import 'last_transaction_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),
                const LanguageToggleWidget(),
                SizedBox(height: size.height * 0.03),
                // My Gold Portfolio Title
                const GoldPortfolioWidget(),
                SizedBox(height: size.height * 0.03),
                //Last Transactions Title
                Text(
                  S.of(context).LastTransactions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const LastTransactionWidget();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
