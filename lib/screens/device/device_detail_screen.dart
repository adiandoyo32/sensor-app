import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/devices.dart';

class DeviceDetailScreen extends StatelessWidget {
  static const String routeName = "device_detail_screen";
  final deviceId;

  DeviceDetailScreen(this.deviceId);

  @override
  Widget build(BuildContext context) {
    final device =
        Provider.of<Devices>(context, listen: false).findById(deviceId);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '${device.deviceId}',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
