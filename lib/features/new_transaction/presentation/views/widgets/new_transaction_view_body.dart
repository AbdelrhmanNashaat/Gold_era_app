import 'dart:developer';

import 'package:calulate_gold_daily_price/core/extensions/number_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  final TextEditingController amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // 🔹 Form key
  bool isLoading = false;

  Map<double, String> ingotsMap = {};
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

      return DropdownMenuItem<String>(
        value: entry.key.toString(),
        child: Text(
          '$gramText — ${entry.value}'.localizedNumber(context),
          style: const TextStyle(fontSize: 14),
        ),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
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

            // Gold Weight
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
                value: selectedGram?.localizedNumber(context),
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
                    color: Colors.grey.shade100,
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
            const SizedBox(height: 22),

            // Amount Paid
            Text(
              S.of(context).AmountPaid,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).enterAmountPaid;
                }
                if (double.tryParse(value.trim()) == null) {
                  return S.of(context).pleaseEnterValidNumber;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: S.of(context).enterAmountPaid,
                suffixText: S.of(context).EGP,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (selectedGram != null && !isLoading)
                    ? _saveTransaction
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        S.of(context).SaveTransaction,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate() || selectedGram == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final selectedTitle = ingotsMap[double.parse(selectedGram!)];
      log('Selected Title: $selectedTitle');
      final amount = double.parse(amountController.text.trim());
      final formattedDate = DateTime.now().toIso8601String();

      final transaction = GoldTransaction(
        weight: selectedTitle!,
        buyPrice: amount,
        date: formattedDate,
      );

      await GoldDatabase.instance.addTransaction(transaction);
      if (!mounted) return;
      Navigator.pop(context);

      setState(() {
        selectedGram = null;
        amountController.clear();
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
    final titles = await GoldIngotsDb.instance.getIngotTitles();
    final Map<double, String> result = {};

    for (final title in titles) {
      final gram = _extractGramFromTitle(title);
      if (gram != null && supportedGrams.contains(gram)) {
        result[gram] = title;
      }
    }

    setState(() {
      ingotsMap = result;
    });
  }
}
