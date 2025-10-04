import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'Language screen.dart';

class MainAuthenticated extends StatelessWidget {
  const MainAuthenticated({super.key});

  Future<Widget> _determineStartScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LanguageSelectionScreen(); // Fallback: no user (should not happen here)
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      return LanguageSelectionScreen(); // First-time user
    }

    final data = userDoc.data();
    if (data == null) {
      throw Exception("User data is null");
    }

    return MainScreen(
      name: data['name'] ?? 'User',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      imageFile: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Something went wrong!\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        return snapshot.data ??  LanguageSelectionScreen(); // Fallback
      },
    );
  }
}
