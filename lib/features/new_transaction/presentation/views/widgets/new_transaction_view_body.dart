import 'dart:developer';

import 'package:calulate_gold_daily_price/core/extensions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n.dart';
import '../../../../get_gold_ingots_price/data/gold_ingots_db.dart';
import '../../../data/gold_database.dart';
import '../../../data/models/gold_model.dart';

class NewTransactionViewBody extends StatefulWidget {
  const NewTransactionViewBody({super.key});

  @override
  State<NewTransactionViewBody> createState() => _NewTransactionViewBodyState();
}

class _NewTransactionViewBodyState extends State<NewTransactionViewBody> {
  String? selectedGram;
  bool isLoading = false;

  // Gram -> Title (e.g., 0.25 -> "0.25 gram ingot")
  Map<double, String> ingotsMap = {};

  // Gram -> Price (e.g., 0.25 -> 2263.336)
  Map<double, String> ingotsPriceMap = {};

  final List<double> supportedGrams = [0.25, 0.5, 1, 2.5, 5, 10];

  @override
  void initState() {
    super.initState();
    getIngotsValues();
  }

  @override
  Widget build(BuildContext context) {
    final items = ingotsMap.entries.map((entry) {
      final gramText = '${entry.key} ${S.of(context).g}'.localizedNumber(
        context,
      );
      final price = ingotsPriceMap[entry.key] ?? "-";
      return DropdownMenuItem<String>(
        value: entry.key.toString(),
        child: Text(
          '$gramText — $price ${S.of(context).EGP}'.localizedNumber(context),
          style: const TextStyle(fontSize: 14),
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).NewTransaction,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            S.of(context).selectGoldWeightAndEnterAmountYouPaid,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 28),

          // Gold Weight Dropdown
          Text(
            S.of(context).GoldWeight,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                S.of(context).selectGoldWeight,
                style: const TextStyle(fontSize: 14),
              ),
              value: selectedGram,
              items: items,
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        selectedGram = value;
                      });
                    },
              buttonStyleData: ButtonStyleData(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 22,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const Spacer(),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (selectedGram != null && !isLoading)
                  ? _saveTransaction
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      S.of(context).SaveTransaction,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveTransaction() async {
    if (selectedGram == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final gram = double.parse(selectedGram!);
      final selectedTitle = ingotsMap[gram];
      final selectedPrice = ingotsPriceMap[gram];

      if (selectedTitle == null || selectedPrice == null) {
        log('Error: Selected ingot not found');
        return;
      }

      final now = DateTime.now();
      final formattedDate = DateFormat('d MMM yyyy').format(now);

      final transaction = GoldTransaction(
        weight: selectedTitle,
        buyPrice: selectedPrice,
        date: formattedDate,
      );

      await GoldDatabase.instance.addTransaction(transaction);
      if (!mounted) return;

      Navigator.pop(context); // close the new transaction view

      setState(() {
        selectedGram = null;
      });
    } catch (e) {
      log('Error saving transaction: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  double? _extractGramFromTitle(String title) {
    final regex = RegExp(r'(\d+(\.\d+)?)');
    final match = regex.firstMatch(title);
    if (match == null) return null;
    return double.tryParse(match.group(1)!);
  }

  Future<void> getIngotsValues() async {
    final allIngots = await GoldIngotsDb.instance.getAllIngots();

    final Map<double, String> titleMap = {};
    final Map<double, String> priceMap = {};

    for (final ingot in allIngots) {
      final gram = _extractGramFromTitle(ingot.title);
      log('Ingot: ${ingot.title}, Gram: $gram, Price: ${ingot.price}');
      if (gram != null && supportedGrams.contains(gram)) {
        titleMap[gram] = ingot.title;
        priceMap[gram] = ingot.price;
        log('parsed price: ${priceMap[gram]}');
      }
    }

    setState(() {
      ingotsMap = titleMap;
      ingotsPriceMap = priceMap;
    });
  }
}
