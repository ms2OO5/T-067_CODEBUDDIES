// notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool appNotifications = true;
  bool promotionalMessages = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved notification preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appNotifications = prefs.getBool("app_notifications") ?? true;
      promotionalMessages = prefs.getBool("promotional_messages") ?? false;
    });
  }

  // Save preferences when user toggles
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("app_notifications", appNotifications);
    await prefs.setBool("promotional_messages", promotionalMessages);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.notificationsTitle),
        backgroundColor: Color(0xFFE4F8F0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: loc.appNotifications,
            subtitle: loc.appNotificationsDesc,
            value: appNotifications,
            onChanged: (val) {
              setState(() => appNotifications = val);
              _savePreferences();
            },
            icon: Icons.notifications_active,
          ),
          const Divider(),
          _buildSwitchTile(
            title: loc.promotionalMessages,
            subtitle: loc.promotionalMessagesDesc,
            value: promotionalMessages,
            onChanged: (val) {
              setState(() => promotionalMessages = val);
              _savePreferences();
            },
            icon: Icons.campaign,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.all(16),
        value: value,
        onChanged: onChanged,
        title: Row(
          children: [
            Icon(icon, color: Color(0xFFE4F8F0)),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
