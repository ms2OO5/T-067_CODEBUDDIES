import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('hi'),
    const Locale('pa'),
  ];

  static String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'hi':
        return 'Hindi';
      case 'pa':
        return 'Punjabi';
      default:
        return 'English';
    }
  }
}
