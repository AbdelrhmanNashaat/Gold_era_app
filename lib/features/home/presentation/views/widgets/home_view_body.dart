import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../all_transaction/presentation/views/all_transaction_view.dart';
import '../../../../new_transaction/data/gold_database.dart';
import '../../../../new_transaction/data/models/gold_model.dart';
import 'get_gold_portfolio_data.dart';
import 'home_quick_actions.dart';
import 'language_toggle.dart';
import 'latest_last_transactions.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> with RouteAware {
  final GlobalKey<LatestLastTransactionsState> latestTransactionsKey =
      GlobalKey();

  @override
  void didPopNext() {
    // Refresh latest transactions when coming back
    latestTransactionsKey.currentState?.refreshTransactions();
    super.didPopNext();
  }

  late Future<List<GoldTransaction>> transactions;
  @override
  void initState() {
    super.initState();
    getGold();
  }

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
                const GetGoldPortfolioData(),
                SizedBox(height: size.height * 0.03),
                //Last Transactions Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).LastTransactions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AllTransactionView();
                            },
                          ),
                        );
                      },
                      child: Text(
                        S.of(context).viewAll,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                const LatestLastTransactions(),
                SizedBox(height: size.height * 0.03),
                const HomeQuickActions(),
                SizedBox(height: size.height * 0.01),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<GoldTransaction>> getGold() async {
    List<GoldTransaction> allTransactions = await GoldDatabase.instance
        .getAllTransactions();
    return allTransactions;
  }
}
