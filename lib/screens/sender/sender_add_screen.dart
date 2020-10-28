import 'package:flutter/material.dart';
import 'package:sensor_app/screens/sender/widgets/sender_add_form.dart';

class SenderAddScreen extends StatelessWidget {
  static const routeName = 'sender_add_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Sender',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: SenderAddForm(),
    );
  }
}
