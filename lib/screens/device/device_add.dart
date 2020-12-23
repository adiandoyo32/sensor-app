import 'package:flutter/material.dart';
import 'package:sensor_app/screens/sender/widgets/sender_add_form.dart';

class DeviceAdd extends StatelessWidget {
  static const routeName = 'device_add';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Device',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: SenderAddForm(),
    );
  }
}
