import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pertanyaan yang Sering Diajukan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            FAQItem(
              question: 'Bagaimana cara mereset kata sandi saya?',
              answer:
                  'Anda dapat mengatur ulang kata sandi Anda dengan mengklik link "Lupa Kata Sandi" di layar login.',
            ),
            FAQItem(
              question: 'Bagaimana cara menghubungi dukungan pelanggan?',
              answer:
                  'Anda dapat menghubungi tim dukungan pelanggan kami melalui email di pemuda@gmail.com atau melalui telepon di +1234567890.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Jika Anda memiliki pertanyaan lain atau memerlukan bantuan lebih lanjut, jangan ragu untuk menghubungi kami:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Text('pemuda@g.com'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10),
                Text('+1234567890'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(answer),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Help(),
  ));
}
