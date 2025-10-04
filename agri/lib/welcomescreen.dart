import 'package:flutter/material.dart';
import 'package:new_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'registratio.dart';


class WelcomeScreen extends StatelessWidget {

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/happy-rural-indian-family-on-260nw-1879150012.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(height: screenHeight * 0.15),

                Image.asset(
                  'assets/images/IMG_3989.PNG',
                  height: 80,
                ),
                const SizedBox(height: 10),
                Text(
                  "KrishiMitra", // localized name
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Text(loc.login, style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                        },
                        child: Text(loc.register, style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
