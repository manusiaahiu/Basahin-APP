import 'package:dashboard/drawer.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/dashboard.dart';

class BasahinNewsScreen extends StatelessWidget {
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'Empat Pemuda',
      'description':
          'Empat Pemuda ini Stress karena Project mereka yang sulit dan mereka menyebut nama Kelompoknya adalah Pemuda Dibasmi Project',
      'image': 'assets/images/pbl.jpg',
    },
    {
      'title': 'Judul Berita 2',
      'description': 'Deskripsi singkat berita 2...',
      'image': 'assets/images/land.png',
    },
    {
      'title': 'Judul Berita 3',
      'description': 'Deskripsi singkat berita 3...',
      'image': 'assets/images/suhu.png',
    },
  ];

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
        title: Text(
          'BasahinNews',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      drawer: AppDrawer(), // Tambahkan drawer di sini
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: NewsCard(article: newsArticles[index]),
          );
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Map<String, String> article;

  const NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.asset(
              article['image']!,
              height: 300.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title']!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  article['description']!,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implementasi navigasi ke detail berita
                    },
                    child: Text(
                      'Baca Selengkapnya',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
