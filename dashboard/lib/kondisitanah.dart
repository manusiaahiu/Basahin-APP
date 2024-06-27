import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class KondisiTanahScreen extends StatefulWidget {
  const KondisiTanahScreen ({super.key});

  @override
  _KondisiTanahState createState() => _KondisiTanahState();
}

class _KondisiTanahState extends State<KondisiTanahScreen> {
  late Future<List<Tanah>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataKondisiTanah();
  }

  Future<List<Tanah>> _fetchDataKondisiTanah() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:3000/api/tanah'),
      );

      // http: //192.168.43.4:3000
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Tanah> data =
            jsonData.map((item) => Tanah.fromJson(item)).toList();
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
        title: const Text('Kondisi Tanah Hari Ini',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Tanah>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<Tanah>> snapshot) {
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
                  title: Text(data.id.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${data.status}'),
                      Text('Waktu: ${data.waktu}'),
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

class Tanah {
  final int id;
  final String status;
  final String waktu;

  Tanah({
    required this.id,
    required this.status,
    required this.waktu,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "waktu": waktu,
      };

  factory Tanah.fromJson(Map<String, dynamic> json) {
    return Tanah(
      id: json["id"] ?? 0,
      status: json["status"] ?? '',
      waktu: json["waktu"] ?? '',
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: KondisiTanahScreen(),
  ));
}
