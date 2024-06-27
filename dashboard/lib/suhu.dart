import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({Key? key}) : super(key: key);

  @override
  _SuhuScreenState createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  late Future<List<Suhu>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataSuhu();
  }

  Future<List<Suhu>> _fetchDataSuhu() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:4000/api/suhu'),
      );

// http: //192.168.43.4:4000
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Suhu> data = jsonData.map((item) => Suhu.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
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
        title: const Text('Suhu Hari Ini',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Suhu>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<Suhu>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return ListTile(
                  title:
                      Text(data.id), // Gunakan data.no langsung sebagai String
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${data.temperature}'),
                      Text('Datetime: ${data.datetime}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Suhu {
  final String id; // Ubah tipe data id menjadi String
  final String temperature;
  final String datetime;

  Suhu({
    required this.id,
    required this.temperature,
    required this.datetime,
  });

  factory Suhu.fromJson(Map<String, dynamic> json) {
    return Suhu(
      id: json["id"].toString(), // Konversi temperature no menjadi String
      temperature: json["temperature"].toString(), // Konversi nilai menjadi String
      datetime: json["datetime"].toString(), // Konversi waktu menjadi String
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SuhuScreen(),
  ));
}
