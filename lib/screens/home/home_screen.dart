import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/home/widgets/card_content.dart';
import 'package:sensor_app/screens/home/widgets/device_type_card.dart';
import 'package:sensor_app/screens/home/widgets/home_card.dart';

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHomeHeader(),
                  SizedBox(height: 56.0),
                  _buildHomeCard(),
                  SizedBox(height: 24.0),
                  _buildDeviceType()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Device Type",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DeviceTypeCard(
                icon: MdiIcons.wave,
                color: Colors.brown,
                title: 'Turbidity',
              ),
              DeviceTypeCard(
                icon: MdiIcons.thermometer,
                color: Colors.red,
                title: 'Temperature',
              ),
              DeviceTypeCard(
                icon: MdiIcons.lightbulbOn,
                color: Colors.yellow[800],
                title: 'LDR',
              ),
              DeviceTypeCard(
                icon: MdiIcons.waves,
                color: Colors.blue,
                title: 'Flow',
              ),
              DeviceTypeCard(
                icon: MdiIcons.waterAlertOutline,
                color: Colors.purple,
                title: 'pH',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sensorku',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
              letterSpacing: 1.25,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              letterSpacing: 1.25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: HomeCard(
              cardMargin: EdgeInsets.only(right: 8.0),
              cardChild: Consumer<Devices>(
                builder: (context, devices, _) => CardContent(
                  title: 'Total Devices',
                  labelContent: '${devices.deviceCount}',
                ),
              ),
            ),
          ),
          Expanded(
            child: HomeCard(
              cardMargin: EdgeInsets.only(left: 8.0),
              cardChild: Consumer<Devices>(
                builder: (context, devices, _) => CardContent(
                  title: 'Active Devices',
                  labelContent: '${devices.activeDeviceCount}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
