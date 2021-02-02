import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/device/device_overview_screen.dart';
import 'package:sensor_app/screens/home/home_screen.dart';
import 'package:sensor_app/screens/device/device_screen.dart';
import 'package:sensor_app/screens/profile/profile_screen.dart';
import 'package:sensor_app/providers/navigation.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  static const String routeName = "base_screen";
  final role;

  BaseScreen(this.role);

  @override
  _BaseScreen createState() => _BaseScreen();
}

class _BaseScreen extends State<BaseScreen> {
  List<Widget> _screen = [];

  @override
  void initState() {
    super.initState();
    if (widget.role == 'admin') {
      setState(() {
        _screen = [
          HomeScreen(),
          DeviceOverviewScreen(),
          ProfileScreen(),
        ];
      });
    } else {
      _screen = [
        HomeScreen(),
        DeviceScreen(),
        ProfileScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<Navigation>(context);
    return Scaffold(
      body: Consumer<Navigation>(
        builder: (context, value, _) => IndexedStack(
          index: navigation.currentIndex,
          children: _screen,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigation.currentIndex,
        selectedItemColor: kPrimaryColor,
        onTap: (index) {
          navigation.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            title: Text('Device'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
