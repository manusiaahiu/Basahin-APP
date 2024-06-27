import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // SwitchListTile(
            //   title: Text('Enable Private Mode'),
            //   value: true, // Ganti dengan nilai sesuai kebutuhan
            //   onChanged: (bool value) {
            //     // Tambahkan fungsi untuk mengubah pengaturan privasi di sini
            //   },
            // ),
            SizedBox(height: 20),
            Text(
              'Security Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Tambahkan fungsi untuk membuka halaman ganti password di sini
              },
            ),
            ListTile(
              title: Text('Two-Factor Authentication'),
              subtitle: Text('Enabled'),
              onTap: () {
                // Tambahkan fungsi untuk mengelola autentikasi dua faktor di sini
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Privacy(),
  ));
}
