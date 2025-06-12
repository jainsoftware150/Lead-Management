import 'package:flutter/material.dart';
import 'package:projec1/ProfilePage.dart';
import 'package:projec1/SettingPage.dart'; // use Material for Icon widget

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.lightBlue,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround         ,
        children: [
          const Icon(Icons.home, size: 28),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            child: const Icon(Icons.settings, size: 28),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const Icon(Icons.person, size: 28),
          ),
        ],
      ),
    );
  }
}
