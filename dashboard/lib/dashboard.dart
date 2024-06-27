import 'package:dashboard/drawer.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/bottom/info.dart';
import 'package:dashboard/bottom/news.dart';
import 'package:dashboard/feedback.dart';
import 'package:dashboard/kondisitanah.dart';
import 'package:dashboard/setting.dart';
import 'package:dashboard/suhu.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var height, width;
  int _currentIndex = 1;

  List imgData = [
    "images/tanah.png",
    "images/suhu.png",
    "images/feedback2.png",
    "images/setting.png",
  ];

  List titles = [
    "Kondisi Tanah",
    "Suhu",
    "Feedback",
    "Setting",
  ];

  final List<Widget> _screens = [
    InfoScreen(), // Placeholder for Info Screen
    DashboardContent(),
    BasahinNewsScreen(), // Placeholder for BasahinNews Screen
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(), // Tambahkan drawer di sini
      body: _screens[_currentIndex],
    );
  }
}

class DashboardContent extends StatelessWidget {
  var height, width;

  List imgData = [
    "images/tanah.png",
    "images/suhu.png",
    "images/feedback2.png",
    "images/news.png",
    "images/setting.png",
  ];

  List titles = [
    "Kondisi Tanah",
    "Suhu",
    "Feedback",
    "BasahinNews",
    "Setting",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: width,
        color: Colors.teal,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              height: height * 0.33,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/pbl.jpg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basahin App",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          "Inventory",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: width,
                padding: EdgeInsets.only(bottom: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: imgData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (titles[index] == "Kondisi Tanah") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KondisiTanahScreen(),
                            ),
                          );
                        }
                        if (titles[index] == "Suhu") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuhuScreen(),
                            ),
                          );
                        }
                        if (titles[index] == "Feedback") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackScreen(),
                            ),
                          );
                        }
                        if (titles[index] == "Setting") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingScreen(),
                            ),
                          );
                        }
                        if (titles[index] == "BasahinNews") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BasahinNewsScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              imgData[index],
                              width: 100,
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
