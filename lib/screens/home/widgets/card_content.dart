import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  const CardContent({this.title, this.labelContent});

  final String title, labelContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.0),
        ),
        SizedBox(height: 12.0),
        Text(
          labelContent,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
