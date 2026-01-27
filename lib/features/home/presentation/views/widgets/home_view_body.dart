import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../all_transaction/data/models/transaction_model.dart';
import '../../../../all_transaction/presentation/views/all_transaction_view.dart';
import 'gold_portfolio_widget.dart';
import 'home_quick_actions.dart';
import 'language_toggle.dart';
import 'latest_last_transactions.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> transactions = [
      // Dummy Data
      TransactionModel(
        id: "1",
        money: "3000",
        weight: "50",
        date: "2024-06-01",
      ),
      TransactionModel(
        id: "2",
        money: "2000",
        weight: "30",
        date: "2024-06-02",
      ),
      TransactionModel(
        id: "3",
        money: "4000",
        weight: "70",
        date: "2024-06-03",
      ),
    ];
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
                const GoldPortfolioWidget(
                  currentValue: "9000",
                  weight: "150",
                  totalPaid: "8500",
                  profit: "500",
                ),
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
                              return AllTransactionView(
                                transactions: transactions,
                              );
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
                LatestLastTransactions(transactions: transactions),
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
}
