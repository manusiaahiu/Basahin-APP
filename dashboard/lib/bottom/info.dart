import 'package:dashboard/dashboard.dart';
import 'package:dashboard/drawer.dart';
import 'package:dashboard/kondisitanah.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<List<Tanah>> _futureDataTanah;
  late Future<List<Suhu>> _futureDataSuhu;

  @override
  void initState() {
    super.initState();
    _futureDataTanah = _fetchDataKondisiTanah();
    _futureDataSuhu = _fetchDataSuhu();
  }

  Future<List<Tanah>> _fetchDataKondisiTanah() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:3000/api/tanah'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Tanah> data =
            jsonData.map((item) => Tanah.fromJson(item)).toList();
        data.sort((a, b) =>
            a.waktu.compareTo(b.waktu)); // Urutkan data berdasarkan waktu
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<Suhu>> _fetchDataSuhu() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:4000/api/suhu'),
      );

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

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Info',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/pbl.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      drawer: AppDrawer(), // Tambahkan drawer di sini
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud,
                  size: 100,
                  color: Colors.blueGrey,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Suhu',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8.0),
                FutureBuilder<List<Suhu>>(
                  future: _futureDataSuhu,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Suhu>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      Suhu latestSuhu =
                          snapshot.data!.last; // Mengambil data suhu terbaru
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (double.parse(latestSuhu.temperature) > 30) {
                          _showSnackBar(context, 'Suhu hari ini sangat panas',
                              Colors.red);
                        } else {
                          _showSnackBar(
                              context, 'Hari yang cerah', Colors.green);
                        }
                      });
                      return Text(
                        '${latestSuhu.temperature}°C', // Menampilkan nilai suhu terbaru
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      );
                    }
                  },
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                ),
                Text(
                  'Kondisi Tanah',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8.0),
                FutureBuilder<List<Tanah>>(
                  future: _futureDataTanah,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Tanah>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      Tanah latestData = snapshot
                          .data!.last; // Mengambil data kondisi tanah terbaru
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Pastikan notifikasi suhu sudah muncul sebelum memunculkan notifikasi kondisi tanah
                        Future.delayed(Duration(seconds: 1), () {
                          if (latestData.status.toLowerCase() == "kering") {
                            _showSnackBar(
                                context,
                                'Kondisi Tanah Kering saat yang tepat menyiram tanaman',
                                Colors.green);
                          } else if (latestData.status.toLowerCase() ==
                              "kelebihan air") {
                            _showSnackBar(
                                context,
                                'Tanah Kelebihan Air, tidak perlu disiram',
                                Colors.blue);
                          } else if (latestData.status.toLowerCase() ==
                              "basah") {
                            _showSnackBar(
                                context,
                                'Tanah Basah siram lah beberapa jam lagi',
                                Colors.green);
                          }
                        });
                      });
                      return Text(
                        latestData
                            .status, // Menampilkan nilai kelembapan air dari data terbaru
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Suhu {
  final String id; // Ubah tipe data no menjadi String
  final String temperature;
  final String datetime;

  Suhu({
    required this.id,
    required this.temperature,
    required this.datetime,
  });

  factory Suhu.fromJson(Map<String, dynamic> json) {
    return Suhu(
      id: json["no"].toString(), // Konversi nilai no menjadi String
      temperature: json["temperature"].toString(), // Konversi nilai menjadi String
      datetime: json["datetime"].toString(), // Konversi waktu menjadi String
    );
  }
}

class Tanah {
  final int no;
  final String status;
  final String waktu;

  Tanah({
    required this.no,
    required this.status,
    required this.waktu,
  });

  factory Tanah.fromJson(Map<String, dynamic> json) {
    return Tanah(
      no: json["no"] ?? 0,
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
