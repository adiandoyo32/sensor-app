import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/home/home_screen.dart';
import 'package:sensor_app/screens/sender/sender_screen.dart';
import 'package:sensor_app/screens/sensor/sensor_screen.dart';

class BaseScreen extends StatefulWidget {
  static const String routeName = "base_screen";
  @override
  _BaseScreen createState() => _BaseScreen();
}

class _BaseScreen extends State<BaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    SenderScreen(),
    SensorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast),
            title: Text('Sender'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            title: Text('Sensor'),
          ),
        ],
      ),
    );
  }
}
