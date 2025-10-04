import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:new_app/l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String message = '';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendResetLink() async {
    final email = emailController.text.trim();
    final t = AppLocalizations.of(context)!;

    if (email.isEmpty) {
      setState(() => message = t.enterEmail);
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() => message = t.resetLinkSent(email));
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          message = t.noUserFound;
        } else if (e.code == 'invalid-email') {
          message = t.invalidEmail;
        } else {
          message = e.message ?? t.unexpectedError;
        }
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE4F8F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.forgotPasswordTitle,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              t.forgotPasswordSubtitle,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: t.emailHint,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  message,
                  style: TextStyle(
                    color: message.startsWith('✅') ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: isLoading ? null : _sendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                t.sendResetLink,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _launchURL('https://punjabandsindbank.co.in'),
                  child: Image.asset(
                    'assets/images/download (4).png',
                    height: screenWidth * 0.12,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _launchURL('https://www.rbi.org.in/'),
                  child: Image.asset(
                    'assets/images/Reserve_Bank_of_India_logo.svg.png',
                    height: screenWidth * 0.12,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
