import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/home/widgets/card_content.dart';
import 'package:sensor_app/screens/home/widgets/home_card.dart';
import 'package:sensor_app/screens/widgets/cards/activity_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHomeHeader(),
                    SizedBox(height: 56.0),
                    _buildHomeCard(),
                    SizedBox(height: 24.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Activities',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ActivityCard(),
                        ActivityCard(),
                        ActivityCard(),
                        ActivityCard(),
                        ActivityCard(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sensorku',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
            letterSpacing: 1.25,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Hi, Lorem Ipsum ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            letterSpacing: 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeCard() {
    return Row(
      children: [
        Expanded(
          child: HomeCard(
            cardMargin: EdgeInsets.only(right: 8.0),
            cardChild: CardContent(
              title: 'Total Senders',
              labelContent: '4',
            ),
          ),
        ),
        Expanded(
          child: HomeCard(
            cardMargin: EdgeInsets.only(left: 8.0),
            cardChild: CardContent(
              title: 'Active',
              labelContent: '4',
            ),
          ),
        ),
      ],
    );
  }
}
