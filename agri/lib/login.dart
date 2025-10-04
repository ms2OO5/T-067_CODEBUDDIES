import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Main.dart';
import 'Forgot.dart';
import 'l10n/app_localizations.dart'; // <-- Make sure this path is correct

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePwd = true;
  bool isLoading = false;
  String error = '';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Sign in to Firebase
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = authResult.user!.uid;
      await
      Future.delayed(Duration(milliseconds:500));
      // Fetch user data from Firestore
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists) {
        setState(() {
          error = AppLocalizations.of(context)!.userNotFound;
        });
        await FirebaseAuth.instance.signOut(); // Sign out if no user doc
        return; // Stop execution here
      }

      final data = doc.data()!;
      final name = data['name'] ?? '';
      final phone = data['phone'] ?? '';

      // Navigate to main screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(
              name: name,
              phone: phone,
              email: email,
              imageFile: null,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          error = AppLocalizations.of(context)!.incorrectEmailOrPassword;
        } else if (e.code == 'invalid-email') {
          error = AppLocalizations.of(context)!.invalidEmail;
        } else {
          error = e.message ?? AppLocalizations.of(context)!.loginFailed;
        }
      });
    } catch (e) {
      setState(() {
        error = AppLocalizations.of(context)!.loginFailed;
      });
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF46A24A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: local.enterEmail,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: _obscurePwd,
                decoration: InputDecoration(
                  hintText: local.password,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePwd ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                  ),
                  child: Text(
                    local.forgotPassword,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (error.isNotEmpty)
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 10),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(local.login, style: const TextStyle(color: Colors.white)),
                ),
              const SizedBox(height: 20),
                ],
              ),

          ),
        ),
    );
  }
}
