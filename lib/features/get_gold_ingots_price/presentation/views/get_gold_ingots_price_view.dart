import 'package:calulate_gold_daily_price/features/get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import 'widgets/get_gold_ingots_price_view_body.dart';

class GetGoldIngotsPriceView extends StatelessWidget {
  const GetGoldIngotsPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
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
      body: SafeArea(
        child: BlocProvider(
          create: (context) => GetGoldIngotsCubit()..fetchGoldIngotsPrice(),
          child: const GetGoldIngotsPriceViewBody(),
        ),
      ),
    );
  }
}
