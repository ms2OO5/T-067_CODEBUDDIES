// privacy_screen.dart
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Settings")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: Text("Make Profile Private"),
          ),
          ListTile(title: Text("Blocked Accounts"), leading: Icon(Icons.block)),
        ],
      ),
    );
  }
}
