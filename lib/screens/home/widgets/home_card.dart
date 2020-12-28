import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({this.cardMargin, this.cardChild});

  final EdgeInsetsGeometry cardMargin;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: cardMargin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x338A959E),
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: cardChild,
    );
  }
}
