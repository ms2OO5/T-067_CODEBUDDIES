import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainauth.dart';
import 'l10n/app_localizations.dart';
import 'Registratio.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user; // Pass the user object

  const EmailVerificationScreen({super.key, required this.user});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isChecking = false;

  Future<void> _checkVerification() async {
    final loc = AppLocalizations.of(context)!;
    setState(() => isChecking = true);

    await widget.user.reload();
    final updatedUser = FirebaseAuth.instance.currentUser!;
    if (updatedUser.emailVerified) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainAuthenticated()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.emailNotVerified)));
    }

    setState(() => isChecking = false);
  }

  Future<void> _resendVerification() async {
    final loc = AppLocalizations.of(context)!;
    try {
      await widget.user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.verificationLinkSent)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.unexpectedError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE4F8F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.verificationLinkSent,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              loc.verifyEmailInstruction,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isChecking ? null : _checkVerification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: isChecking
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(loc.register, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendVerification,
              child: Text(
                loc.resendVerification,
                style: const TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
