import 'package:flutter/material.dart';
import '../../../../../main.dart';
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
  final GlobalKey<GetGoldPortfolioDataState> portfolioKey = GlobalKey();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    latestTransactionsKey.currentState?.refreshTransactions();
    portfolioKey.currentState?.refreshPortfolio();
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
                GetGoldPortfolioData(key: portfolioKey),
                LatestLastTransactions(key: latestTransactionsKey),
                SizedBox(height: size.height * 0.02),
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
