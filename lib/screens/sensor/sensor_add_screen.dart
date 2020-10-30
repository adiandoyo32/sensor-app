import 'package:flutter/material.dart';
import 'package:sensor_app/screens/sensor/widgets/sensor_add_form.dart';

class SensorAddScreen extends StatelessWidget {
  static const routeName = 'sensor_add_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Sensor',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: SensorAddForm(),
    );
  }
}
