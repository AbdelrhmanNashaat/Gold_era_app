import 'package:flutter/material.dart';

extension NumberLocalization on String {
  String localizedNumber(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    if (langCode != 'ar') return this;

    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    final buffer = StringBuffer();

    for (final char in characters) {
      if (RegExp(r'\d').hasMatch(char)) {
        buffer.write(arabicDigits[int.parse(char)]);
      } else {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }
}
