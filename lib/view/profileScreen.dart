import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFC1E698),
                child: Icon(Icons.person, color: Colors.green, size: 32),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Guest', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('Not signed in', style: TextStyle(color: Colors.black54)),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          const Text('Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.notifications), title: Text('Notifications')),
                Divider(height: 0),
                ListTile(leading: Icon(Icons.lock), title: Text('Privacy')),
                Divider(height: 0),
                ListTile(leading: Icon(Icons.info_outline), title: Text('About')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}








