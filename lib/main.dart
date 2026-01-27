import 'package:calulate_gold_daily_price/features/get_gold_ingots_price/presentation/manager/get_gold_ingots_cubit/get_gold_ingots_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/home/presentation/manager/language_cubit.dart';
import 'features/home/presentation/views/home_view.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
            ),
            home: BlocProvider(
              create: (context) => GetGoldIngotsCubit()..fetchGoldIngotsPrice(),
              child: const HomeView(),
            ),
          );
        },
      ),
    );
  }
}
