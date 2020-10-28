import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.text,
    this.onPress,
  });

  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: kPrimaryColor,
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
