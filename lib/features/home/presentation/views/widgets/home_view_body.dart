import 'package:flutter/material.dart';
import 'gold_portfolio_widget.dart';
import 'language_toggle.dart';

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
              children: [
                SizedBox(height: size.height * 0.02),
                const LanguageToggleWidget(),
                SizedBox(height: size.height * 0.03),
                // My Gold Portfolio Title
                const GoldPortfolioWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
