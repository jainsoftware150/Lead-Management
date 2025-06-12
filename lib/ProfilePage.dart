import 'package:flutter/material.dart';

import 'footer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
         Expanded(child: Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             children: [
               const CircleAvatar(
                 radius: 50,
                 backgroundImage: NetworkImage(
                   'https://i.pravatar.cc/300', // Sample avatar
                 ),
               ),
               const SizedBox(height: 16),
               const Text(
                 'peyanshu verma',
                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 8),
               const Text(
                 'peyanshu@gmail.com',
                 style: TextStyle(fontSize: 16, color: Colors.grey),
               ),
               const SizedBox(height: 24),
               ListTile(
                 leading: const Icon(Icons.phone),
                 title: const Text('Phone'),
                 subtitle: const Text('+91 9876543210'),
               ),
               ListTile(
                 leading: const Icon(Icons.location_on),
                 title: const Text('Address'),
                 subtitle: const Text('jain software x ,Raipur'),
               ),
               const Spacer(),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton.icon(
                   icon: const Icon(Icons.logout),
                   label: const Text("Logout"),
                   onPressed: () {
                     // Handle logout
                     Navigator.pop(context);
                   },
                 ),
               ),
             ],
           ),
         ),),
    const Footer()
        ],
      )
    );
  }
}
