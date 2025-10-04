// security_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityScreen extends StatefulWidget {
  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _is2FAEnabled = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    String? password = await _secureStorage.read(key: "vault_password");
    String? twoFA = await _secureStorage.read(key: "2fa_enabled");
    setState(() {
      _is2FAEnabled = twoFA == "true";
    });
    if (password != null) {
      _passwordController.text = password;
    }
  }

  Future<void> _changePassword() async {
    if (_passwordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")));
      return;
    }
    await _secureStorage.write(
        key: "vault_password", value: _passwordController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Vault password updated!")));
  }

  Future<void> _toggle2FA(bool enable) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    // Send email verification first
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Verification email sent. Please verify your email first.")));
      return;
    }

    bool confirmed = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(enable ? "Enable 2FA?" : "Disable 2FA?"),
          content: Text(enable
              ? "Are you sure you want to enable Two-Factor Authentication?"
              : "Are you sure you want to disable Two-Factor Authentication?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Confirm")),
          ],
        ));

    if (confirmed) {
      await _secureStorage.write(
          key: "2fa_enabled", value: enable ? "true" : "false");
      setState(() {
        _is2FAEnabled = enable;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(enable
              ? "Two-Factor Authentication enabled!"
              : "Two-Factor Authentication disabled!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Security Settings")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Vault Password"),
                subtitle: Column(
                  children: [
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "New Password"),
                      obscureText: true,
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration:
                      InputDecoration(labelText: "Confirm Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: _changePassword, child: Text("Update"))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: SwitchListTile(
                secondary: Icon(Icons.shield),
                title: Text("Two-Factor Authentication (2FA)"),
                subtitle: Text(_is2FAEnabled
                    ? "2FA is currently enabled."
                    : "2FA is currently disabled."),
                value: _is2FAEnabled,
                onChanged: _toggle2FA,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
