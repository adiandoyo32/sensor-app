import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/device/device_detail/device_information.dart';

class DeviceDetailScreen extends StatefulWidget {
  static const String routeName = "device_detail_screen";
  final deviceId;

  DeviceDetailScreen(this.deviceId);

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      icon: Icon(
        Icons.info,
        color: kPrimaryColor,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.timeline,
        color: kPrimaryColor,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final device =
        Provider.of<Devices>(context, listen: false).findById(widget.deviceId);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '${device.deviceId}',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _controller,
          tabs: list,
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        DeviceInformation(device: device),
        Center(
            child: Text(
          _selectedIndex.toString(),
          style: TextStyle(fontSize: 40),
        )),
      ]),
      // body: DeviceInformation(device: device),
    );
  }
}
