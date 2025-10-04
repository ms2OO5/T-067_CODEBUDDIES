
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/locale_provider.dart';
import 'home.dart';
import 'settings.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';
import 'wrapper.dart';
import 'saved_scenarios_screen.dart';
import 'farming_community_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const agri(),
    ),
  );
}

class agri extends StatelessWidget {
  const agri({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'agri',
      debugShowCheckedModeBanner: false,
      locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const Wrapper(),
    );
  }
}

// ------------------------ MainScreen ------------------------

class MainScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String? email;
  final File? imageFile;

  const MainScreen({
    Key? key,
    required this.name,
    required this.phone,
    this.email,
    this.imageFile,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tab = 0;
  DateTime? _lastBackPress;

  late String name;
  late String phone;
  String? email;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    phone = widget.phone;
    email = widget.email;
    imageFile = widget.imageFile;
  }

  Widget get _settingsScreen => SettingsScreen(
    name: name,
    phone: phone,
    email: email,
    imageFile: imageFile,
    onProfileUpdate: (newName, newEmail, newPhone, newImage) {
      setState(() {
        name = newName;
        email = newEmail;
        phone = newPhone;
        imageFile = newImage;
      });
    },
  );

  Future<bool> _onWillPop() async {
    if (_tab != 0) {
      // If not on Home tab, go back to Home
      setState(() => _tab = 0);
      return false; // Prevent exiting the app
    } else {
      // If on Home tab, require double press
      DateTime now = DateTime.now();
      if (_lastBackPress == null || now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
        _lastBackPress = now;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Press back again to exit')),
        );
        return false; // Prevent exit on first press
      }
      return true; // Exit app
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIXED: Properly instantiate widget classes with () to create instances
    final screens = <Widget>[
      HomeScreen(name: name, phone: phone, email: email, imageFile: imageFile),
      SavedScenariosScreen(), // FIXED: Added () to instantiate the widget
      FarmingCommunityScreen(), // FIXED: Added () to instantiate the widget
      _settingsScreen,
    ];

    final loc = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(index: _tab, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tab,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => setState(() => _tab = i),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: loc.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.save),
              label: "Saves",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat),
              label: "Community",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: loc.settings,
            ),
          ],
        ),
      ),
    );
  }
}
