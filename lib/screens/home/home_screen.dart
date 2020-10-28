import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/widgets/cards/activity_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                    children: [
                      TextSpan(text: "My "),
                      TextSpan(
                        text: "Home",
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildHomeCard(context),
              ActivityCard(),
              ActivityCard(),
              ActivityCard(),
              ActivityCard(),
              ActivityCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x338A959E),
              offset: Offset(0, 15),
              blurRadius: 30,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Sensor",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "8",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Active",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "3",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
