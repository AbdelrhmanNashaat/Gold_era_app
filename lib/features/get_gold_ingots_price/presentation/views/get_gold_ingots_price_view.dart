import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import 'widgets/get_gold_ingots_price_view_body.dart';

class GetGoldIngotsPriceView extends StatelessWidget {
  const GetGoldIngotsPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          S.of(context).GoldIngots,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(child: GetGoldIngotsPriceViewBody()),
    );
  }
}
