import 'package:flutter/material.dart';

class Themee extends StatelessWidget {
  const Themee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Theme Example'),
      // ),
      // body: Center(
      //   child: Text(
      //     'This is a themed widget!',
      //     style: Theme.of(context).textTheme.headline6,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).primaryColor,
      //         ),
      //         child: Text(
      //           'Drawer Header',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('Item 1'),
      //         onTap: () {
      //           // Tambahkan aksi ketika item 1 diklik
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Item 2'),
      //         onTap: () {
      //           // Tambahkan aksi ketika item 2 diklik
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Themee(),
    theme: ThemeData(
      primaryColor: Colors.teal, // Ubah warna primer sesuai kebutuhan
      hintColor: Colors.orange, // Ubah warna aksen sesuai kebutuhan
      // Tambahkan konfigurasi tema lainnya di sini
    ),
  ));
}
