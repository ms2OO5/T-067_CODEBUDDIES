import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:flutter/services.dart'; // 👈 for SystemNavigator.pop()

import 'main.dart'; // MainScreen with user data
import 'Language screen.dart'; // For new users
import 'login.dart'; // Fallback if profile is incomplete
import 'splashscreen.dart'; // Import the new splash screen

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _showSplash = true;
  bool _isCompromised = false; // track if rooted/jailbroken
  Map<String, dynamic>? _profileData;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _startSplashAndLoadData();
  }

  Future<void> _startSplashAndLoadData() async {
    final splashDuration = const Duration(seconds: 10);
    final splashTimer = Future.delayed(splashDuration);

    // 🔒 Step 1: Root/Jailbreak check
    try {
      final jailbreak = JailbreakRootDetection();
      bool jailbroken = await jailbreak.isJailBroken;

      if (jailbroken) {
        _isCompromised = true;

        // 🔥 Safe exit (Play Store friendly)
        SystemNavigator.pop();
        return; // stop further execution
      }
    } catch (e) {
      debugPrint("Root/Jailbreak check failed: $e");
    }

    // 🔒 If not compromised, check Firebase user
    if (!_isCompromised) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          if (doc.exists) {
            _profileData = doc.data();
          } else {
            _profileData = null;
          }
          _currentUser = user;
        } catch (e) {
          _profileData = null;
          _currentUser = user;
        }
      } else {
        _profileData = null;
        _currentUser = null;
      }
    }

    // Step 3: Wait for splash duration
    await splashTimer;

    // Step 4: Remove splash and update UI
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Splash screen
    if (_showSplash) {
      return FuturisticSplashScreen(
        title: "KrishiMitra",
        subtitle: "Your Virtual Farm......",
        duration: const Duration(seconds: 12),
        primaryColor: const Color(0x5046A24A),
        accentColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0x6546A24A),
        onComplete: () {},
      );
    }

    // 🔒 If compromised (extra safety, though SystemNavigator.pop() will already close app)
    if (_isCompromised) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "⚠️ Security Alert\n\nThis device is rooted or jailbroken.\nMyMitra cannot run on compromised devices.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // User authenticated flow
    if (_currentUser != null) {
      if (_profileData != null) {
        return MainScreen(
          name: _profileData!['name'] ?? 'User',
          phone: _profileData!['phone'] ?? '',
          email: _profileData!['email'] ?? '',
          imageFile: null,
        );
      } else {
        return const LoginScreen();
      }
    } else {
      return LanguageSelectionScreen();
    }
  }
}
