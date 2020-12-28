import 'package:flutter/material.dart';

class DeviceTypeCard extends StatelessWidget {
  const DeviceTypeCard({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.title,
    this.subtitle,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 80,
      margin: EdgeInsets.only(right: 8.0),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 24.0,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                "2 devices",
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
