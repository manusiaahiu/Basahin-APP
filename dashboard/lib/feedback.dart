import 'dart:convert';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<FeedbackScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _masukanController = TextEditingController();
  bool _isSubmitting = false;
  String _responseMessage = '';
  Color _responseColor = Colors.green; // Tambahkan warna respons

  Future<void> _submitFeedback() async {
    setState(() {
      _isSubmitting = true;
    });

    // Validasi apakah email dan masukan sudah diisi
    if (_emailController.text.isEmpty || _masukanController.text.isEmpty) {
      setState(() {
        _isSubmitting = false;
        _responseMessage = 'Email and feedback cannot be empty!';
        _responseColor = Colors.red; // Set warna respons ke merah
      });
      return; // Keluar dari method jika ada isian yang kosong
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'masukan': _masukanController.text,
        }),
      );

      setState(() {
        _isSubmitting = false;
        if (response.statusCode == 200) {
          _responseMessage = 'Feedback sent successfully!';
          _emailController.clear();
          _masukanController.clear();
          _responseColor = Colors.green; // Set warna respons ke hijau
        } else {
          _responseMessage = 'Failed to send feedback. Please try again.';
          _responseColor = Colors.red; // Set warna respons ke merah
        }
      });
    } catch (error) {
      setState(() {
        _isSubmitting = false;
        _responseMessage = 'An error occurred. Please try again.';
        _responseColor = Colors.red; // Set warna respons ke merah
      });
    }
  }

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
        title: const Text(
          'Send Feedback',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _masukanController,
                  decoration: const InputDecoration(
                    labelText: 'Masukan',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 20),
              _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitFeedback,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text(
                        'Submit Feedback',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 20),
              Text(
                _responseMessage,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      _responseColor, // Gunakan warna respons yang diperbarui
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const FeedbackScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    ),
  );
}
