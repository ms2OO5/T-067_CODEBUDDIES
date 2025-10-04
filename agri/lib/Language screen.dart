import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_app/l10n/app_localizations.dart';
import 'package:new_app/providers/locale_provider.dart';
import 'welcomescreen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'हिंदी (Hindi)',
    'ਪੰਜਾਬੀ (Punjabi)',
  ];

  Locale _getLocaleFromLanguage(String language) {
    if (language.contains('English')) return const Locale('en');
    if (language.contains('हिंदी')) return const Locale('hi');
    if (language.contains('ਪੰਜਾਬੀ')) return const Locale('pa');
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F8F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.chooseLanguage,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.selectPreferredLanguage,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.youSelected,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 10),
              _buildSelectedLanguageTile(),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.availableLanguages,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: languages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      _buildLanguageTile(languages[index]),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.next,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedLanguageTile() {
    return _buildLanguageContainer(
      child: Row(
        children: [
          Image.asset('assets/images/Flag Image.png', width: 24),
          const SizedBox(width: 10),
          Text(
            selectedLanguage,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      borderColor: Colors.teal.shade300,
    );
  }

  Widget _buildLanguageTile(String language) {
    final isSelected = selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() => selectedLanguage = language);

        // Update locale globally using provider
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        provider.setLocale(_getLocaleFromLanguage(language));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Image.asset('assets/images/Flag Image.png', width: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  language,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Radio<String>(
                value: language,
                groupValue: selectedLanguage,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedLanguage = value);
                    final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                    provider.setLocale(_getLocaleFromLanguage(value));
                  }
                },
                activeColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageContainer({
    required Widget child,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
