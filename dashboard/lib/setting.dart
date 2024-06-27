import 'package:dashboard/dashboard.dart';
import 'package:dashboard/setting/about.dart';
import 'package:dashboard/setting/account.dart';
import 'package:dashboard/setting/help.dart';
import 'package:dashboard/setting/privacy.dart';
import 'package:dashboard/setting/theme.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
        ),
        title: const Text('Settings',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text('Account'),
            subtitle: const Text('Manage your account settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Account(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.teal),
            title: const Text('Notifications'),
            subtitle: const Text('Notification settings'),
            trailing: Switch(
              value:
                  true, // Example value, you can link this to a state management solution
              onChanged: (bool value) {
                // Handle the switch state change
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.teal),
            title: const Text('Privacy'),
            subtitle: const Text('Privacy and security settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Privacy(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.palette, color: Colors.teal),
            title: const Text('Theme'),
            subtitle: const Text('Customize the app theme'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Themee(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.teal),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help and support'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Help(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.teal),
            title: const Text('About'),
            subtitle: const Text('About the app'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.teal,
              ),
              child: const Text('Logout',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const SettingScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    ),
  );
}
