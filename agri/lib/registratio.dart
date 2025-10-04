import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'l10n/app_localizations.dart';
import 'emailverifier.dart'; // new screen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _register() async {
    final loc = AppLocalizations.of(context)!;
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage(loc.fieldsRequired);
      return;
    }

    if (password != confirmPassword) {
      _showMessage(loc.passwordMismatch);
      return;
    }

    try {
      setState(() => isLoading = true);

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': Timestamp.now(),
      });

      // Navigate to verification screen with current user object
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EmailVerificationScreen(user: userCredential.user!),
        ),
      );


    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? loc.registrationFailed);
    } catch (e) {
      _showMessage(loc.unexpectedError);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF46A24A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const SizedBox(height: 25),

              _buildTextField(controller: nameController, hintText: loc.fullName),
              _buildTextField(
                controller: emailController,
                hintText: loc.emailRequired,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: phoneController,
                hintText: loc.phoneOptional,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: passwordController,
                hintText: loc.password,
                obscure: !_passwordVisible,
                suffixIcon: _passwordVisible ? Icons.visibility : Icons.visibility_off,
                onSuffixTap: () => setState(() => _passwordVisible = !_passwordVisible),
              ),
              _buildTextField(
                controller: confirmPasswordController,
                hintText: loc.confirmPassword,
                obscure: !_confirmPasswordVisible,
                suffixIcon: _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                onSuffixTap: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(loc.register, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loc.alreadyAccount),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      loc.login,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

                ],
              ),

          ),
        ),

    );
  }
}
