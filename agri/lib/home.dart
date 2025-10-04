
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:new_app/l10n/app_localizations.dart';
import 'edit profile.dart';
import 'widgets/language_picker.dart';
import 'language_manager.dart';
import 'simulations.dart'; // <-- make sure this contains FarmSimulationScreen
import 'weather_screen.dart'; // ADD: Import weather screen

class HomeScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String? email;
  final File? imageFile;
  final void Function(String newName, String? newEmail, String newPhone, File? newImage)? onProfileUpdate;

  const HomeScreen({
    Key? key,
    required this.name,
    required this.phone,
    this.email,
    this.imageFile,
    this.onProfileUpdate,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String name;
  late String phone;
  String? email;
  File? image;
  String selectedLanguage = 'en';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    phone = widget.phone;
    email = widget.email;
    image = widget.imageFile;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (image != null) {
        precacheImage(FileImage(image!), context);
      }
      precacheAssets(context);
    });
  }

  Future<void> precacheAssets(BuildContext context) async {
    final assets = [

    ];

    for (final asset in assets) {
      await precacheImage(AssetImage(asset), context);
    }
  }

  Future<void> _editProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          currentName: name,
          currentPhone: phone,
          currentEmail: email,
          initialImageFile: image,
          onSave: (newName, newEmail, newPhone, newImg) {
            setState(() {
              name = newName;
              email = newEmail;
              phone = newPhone;
              image = newImg;
            });
            widget.onProfileUpdate?.call(newName, newEmail, newPhone, newImg);
          },
        ),
      ),
    );
  }

  Future<void> _openLanguagePicker() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LanguageScreen(),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch \$url')),
      );
    }
  }

  // ADD: Navigate to Weather Screen
  void _openWeatherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherScreen()),
    );
  }

  // ADD: Navigate to Mandi Prices Screen (placeholder for now)
  void _openMandiPricesScreen() {
    // TODO: Create a proper Mandi Prices screen later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📊 Mandi Prices screen coming soon!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFF46A24A),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'KrishiMitra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting Section
                    Text(
                      'Good Morning!',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: _editProfile,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: image != null
                                ? ClipOval(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Action Buttons Row
                    Row(
                      children: [
                        _buildSmallActionButton(
                          Icons.language,
                          onTap: _openLanguagePicker,
                        ),
                        const SizedBox(width: 10),
                        _buildSmallActionButton(
                          Icons.edit,
                          onTap: _editProfile,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    // Weather Card - ADD: Navigation on tap
                    _buildWeatherCard(),

                    const SizedBox(height: 20),
                    // Market Prices Card - ADD: Navigation on tap
                    _buildMarketPricesCard(),

                    const SizedBox(height: 20),
                    // FEATURED SERVICES CARD: Tap to navigate farming simulation screen!
                    _buildFeaturedCard(context),

                    const SizedBox(height: 20),
                    // REMOVE 'more' option, keep UI clean!

                    const SizedBox(height: 30),

                    // Partner Logos
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildSmallActionButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.black54,
        ),
      ),
    );
  }

  // UPDATED: Add navigation to Weather Screen
  Widget _buildWeatherCard() {
    return GestureDetector( // ADD: Wrap in GestureDetector
      onTap: _openWeatherScreen, // ADD: Navigation function
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Weather",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.wb_sunny,
                        color: Colors.orange,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '30°C',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sunny',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Correct navigation function for Mandi Prices
  Widget _buildMarketPricesCard() {
    return GestureDetector( // ADD: Wrap in GestureDetector
      onTap: _openMandiPricesScreen, // FIXED: Correct navigation function
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mandi Prices',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/IMG_3974.PNG",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Wheat',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'Rs.1,980/Q',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(-16777216),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feature Card: Navigates to Farm Simulation Screen
  Widget _buildFeaturedCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainFarmScreen()), // Assume correct import
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF46A24A),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                "assets/images/IMG_3971.PNG",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Farm Simulation",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Explore what if-scenario',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoImage(String path, double width, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          path,
          height: width * 0.08,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
