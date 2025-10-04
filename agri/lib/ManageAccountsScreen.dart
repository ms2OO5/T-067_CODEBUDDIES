import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'change_email_flow.dart';
import 'change_phone_flow.dart';
import 'change_password_flow.dart';
import 'welcomescreen.dart';

class ManageAccountsScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String? email;

  const ManageAccountsScreen({
    Key? key,
    required this.name,
    required this.phone,
    this.email,
  }) : super(key: key);

  @override
  State<ManageAccountsScreen> createState() => _ManageAccountsScreenState();
}

class _ManageAccountsScreenState extends State<ManageAccountsScreen> {
  late String phone;
  String? email;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    email = widget.email;
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _updateFirestore(Map<String, dynamic> data) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(data);
    }
  }

  Future<void> _changeEmail() async {
    final newEmail = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => const ChangeEmailFlow()),
    );
    if (newEmail == null) return;

    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
      await _updateFirestore({'email': newEmail});
      setState(() => email = newEmail);
      _snack('Email updated successfully');
    } on FirebaseAuthException catch (e) {
      _snack(e.message ?? 'Email update failed');
    }
  }

  Future<void> _changePhone() async {
    final newPhone = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => const ChangePhoneFlow()),
    );
    if (newPhone == null) return;

    await _updateFirestore({'phone': newPhone});
    setState(() => phone = newPhone);
    _snack('Phone updated successfully');
  }

  Future<void> _changePassword() async {
    final newPassword = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => const ChangePasswordFlow()),
    );
    if (newPassword == null) return;

    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      _snack('Password updated successfully');
    } on FirebaseAuthException catch (e) {
      _snack(e.message ?? 'Password update failed');
    }
  }

  Future<void> _logout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
          (_) => false,
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCBEBDD),
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 48),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EBF7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Manage Accounts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Icon(Icons.account_circle, size: 80, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'My Account Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            _buildActionButton('Change Phone', Icons.phone, _changePhone),
            if (email?.isNotEmpty ?? false)
              _buildActionButton('Change Email', Icons.email, _changeEmail),
            _buildActionButton('Change Password', Icons.lock, _changePassword),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB6E1CE),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Log out',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
