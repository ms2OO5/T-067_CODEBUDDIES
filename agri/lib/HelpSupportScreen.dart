import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.helpSupportTitle),
        backgroundColor: Color(0xFFE4F8F0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            context,
            icon: Icons.question_answer,
            title: loc.faqs,
            subtitle: loc.faqsDesc,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FAQsPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            icon: Icons.support_agent,
            title: loc.contactUs,
            subtitle: loc.contactUsDesc,
            onTap: () {
              _showContactDialog(context, loc);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: Color(0xFFE4F8F0), size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  void _showContactDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc.contactUs),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xFFE4F8F0)),
              title: Text(loc.emailSupport),
              subtitle: const Text("support@myapp.com"),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement email launcher
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: Text(loc.callSupport),
              subtitle: const Text("+91 9876543210"),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement phone launcher
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.close),
          ),
        ],
      ),
    );
  }
}

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.faqs),
        backgroundColor: Color(0xFFE4F8F0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            leading: const Icon(Icons.help_outline),
            title: Text(loc.faq1Q),
            children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(loc.faq1A),
            )],
          ),
          ExpansionTile(
            leading: const Icon(Icons.help_outline),
            title: Text(loc.faq2Q),
            children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(loc.faq2A),
            )],
          ),
        ],
      ),
    );
  }
}
