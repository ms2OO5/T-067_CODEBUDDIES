import 'dart:io';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import 'edit profile.dart';
import 'SecurityScreen.dart';
import 'ManageAccountsScreen.dart';
import 'PrivacyScreen.dart';
import 'Language_manager.dart';
import 'NotificationsScreen.dart';
import 'FeedbackScreen.dart';
import 'HelpSupportScreen.dart';
import 'TermsPoliciesScreen.dart';

class SettingsScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String? email;
  final File? imageFile;
  final Function(String, String?, String, File?) onProfileUpdate;

  const SettingsScreen({
    Key? key,
    required this.name,
    required this.phone,
    this.email,
    this.imageFile,
    required this.onProfileUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FB),
      body: Column(
        children: [
          _header(local.settingsTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _sectionTitle(local.account),
                _tile(
                  context,
                  local.editProfile,
                  'assets/images/Profile.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        currentName: name,
                        currentPhone: phone,
                        currentEmail: email,
                        initialImageFile: imageFile,
                        onSave: onProfileUpdate,
                      ),
                    ),
                  ),
                ),
                _tile(
                  context,
                  local.security,
                  'assets/images/material-symbols_privacy-tip-outline.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SecurityScreen()),
                  ),
                ),
                _tile(
                  context,
                  local.manageAccounts,
                  'assets/images/iconamoon_profile-light.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManageAccountsScreen(
                        name: name,
                        phone: phone,
                        email: email ?? '',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _sectionTitle(local.appSettings),
                _tile(
                  context,
                  local.language,
                  'assets/images/Global.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LanguageScreen()),
                  ),
                ),
                _tile(
                  context,
                  local.notifications,
                  'assets/images/iconamoon_notification.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotificationsScreen()),
                  ),
                ),
                const SizedBox(height: 20),
                _sectionTitle(local.supportAndAbout),
                _tile(
                  context,
                  local.feedback,
                  'assets/images/material-symbols_credit-card-outline.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeedbackScreen()),
                  ),
                ),
                _tile(
                  context,
                  local.helpSupport,
                  'assets/images/mdi_question-mark-circle-outline.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpSupportScreen()),
                  ),
                ),
                _tile(
                  context,
                  local.termsPolicies,
                  'assets/images/tabler_circle-letter-i.png',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TermsPoliciesScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(String title) => Container(
    width: double.infinity,
    padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
    decoration: const BoxDecoration(
      color: Color(0xFF6A8D59),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Row(
      children: [
        const Icon(Icons.settings),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  static Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  );

  static Widget _tile(BuildContext ctx, String title, String iconPath, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(iconPath, width: 28, height: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      );
}
