// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Gold Ingots`
  String get GoldIngots {
    return Intl.message('Gold Ingots', name: 'GoldIngots', desc: '', args: []);
  }

  /// `EGP`
  String get EGP {
    return Intl.message('EGP', name: 'EGP', desc: '', args: []);
  }

  /// `Current Value`
  String get CurrentValue {
    return Intl.message(
      'Current Value',
      name: 'CurrentValue',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get Weight {
    return Intl.message('Weight', name: 'Weight', desc: '', args: []);
  }

  /// `Profit`
  String get Profit {
    return Intl.message('Profit', name: 'Profit', desc: '', args: []);
  }

  /// `Total Paid`
  String get TotalPaid {
    return Intl.message('Total Paid', name: 'TotalPaid', desc: '', args: []);
  }

  /// `g`
  String get g {
    return Intl.message('g', name: 'g', desc: '', args: []);
  }

  /// `Last Transactions`
  String get LastTransactions {
    return Intl.message(
      'Last Transactions',
      name: 'LastTransactions',
      desc: '',
      args: [],
    );
  }

  /// `New Transaction`
  String get NewTransaction {
    return Intl.message(
      'New Transaction',
      name: 'NewTransaction',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: '', args: []);
  }

  /// `All Transactions`
  String get AllTransactions {
    return Intl.message(
      'All Transactions',
      name: 'AllTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Total Transactions`
  String get TotalTransactions {
    return Intl.message(
      'Total Transactions',
      name: 'TotalTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Select gold weight`
  String get selectGoldWeightAndEnterAmountYouPaid {
    return Intl.message(
      'Select gold weight',
      name: 'selectGoldWeightAndEnterAmountYouPaid',
      desc: '',
      args: [],
    );
  }

  /// `Gold Weight`
  String get GoldWeight {
    return Intl.message('Gold Weight', name: 'GoldWeight', desc: '', args: []);
  }

  /// `Select gram`
  String get selectGoldWeight {
    return Intl.message(
      'Select gram',
      name: 'selectGoldWeight',
      desc: '',
      args: [],
    );
  }

  /// `Save Transaction`
  String get SaveTransaction {
    return Intl.message(
      'Save Transaction',
      name: 'SaveTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Amount Paid`
  String get AmountPaid {
    return Intl.message('Amount Paid', name: 'AmountPaid', desc: '', args: []);
  }

  /// `Enter amount`
  String get enterAmountPaid {
    return Intl.message(
      'Enter amount',
      name: 'enterAmountPaid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get pleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `No Transactions Yet`
  String get NoTransactionsYet {
    return Intl.message(
      'No Transactions Yet',
      name: 'NoTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Stamping`
  String get MechanicalAndStamping {
    return Intl.message(
      'Stamping',
      name: 'MechanicalAndStamping',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
