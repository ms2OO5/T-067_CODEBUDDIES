import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  final Map<String, Locale> languageMap = {
    'English': const Locale('en'),
    'हिंदी (Hindi)': const Locale('hi'),
    'ਪੰਜਾਬੀ (Punjabi)': const Locale('pa'),
  };

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale ?? const Locale('en');
    final localizations = AppLocalizations.of(context)!;

    final currentLanguage = languageMap.entries.firstWhere(
          (entry) => entry.value.languageCode == currentLocale.languageCode,
      orElse: () => const MapEntry('English', Locale('en')),
    ).key;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF46A24A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                Text(
                  localizations.chooseLanguage,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localizations.youSelected,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Flag Image.png', width: 24),
                      const SizedBox(width: 10),
                      Text(currentLanguage),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(localizations.allLanguages,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: languageMap.keys.map((language) {
                return RadioListTile<String>(
                  title: Row(
                    children: [
                      const SizedBox(width: 16),
                      Image.asset('assets/images/Flag Image.png', width: 24),
                      const SizedBox(width: 10),
                      Text(language),
                    ],
                  ),
                  value: language,
                  groupValue: currentLanguage,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    final selectedLocale = languageMap[value]!;
                    provider.setLocale(selectedLocale);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
