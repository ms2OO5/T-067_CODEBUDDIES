// terms_policies_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class TermsPoliciesScreen extends StatelessWidget {
  const TermsPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.termsTitle),
        backgroundColor: Color(0xFFE4F8F0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              loc.termsHeading,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildPoint(loc.termsPoint1),
            _buildPoint(loc.termsPoint2),
            _buildPoint(loc.termsPoint3),
            _buildPoint(loc.termsPoint4),
            _buildPoint(loc.termsPoint5),
            _buildPoint(loc.termsPoint6),
            const SizedBox(height: 20),
            Text(
              loc.termsThanks,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFE4F8F0) , size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
