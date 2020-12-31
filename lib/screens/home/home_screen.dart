import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/home/widgets/card_content.dart';
import 'package:sensor_app/screens/home/widgets/device_type_card.dart';
import 'package:sensor_app/screens/home/widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Devices>(context).fetchDeviceTypeCount().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refreshDevices(BuildContext context) async {
    await Provider.of<Devices>(context, listen: false).fetchDevices();
    await Provider.of<Devices>(context, listen: false).fetchDeviceTypeCount();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(kPrimaryLightColor);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: () => _refreshDevices(context),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
        _isLoading
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                scrollDirection: Axis.horizontal,
                child: Consumer<Devices>(
                  builder: (context, devices, _) => Row(
                    children: [
                      DeviceTypeCard(
                        icon: MdiIcons.wave,
                        color: Colors.brown,
                        title: 'Turbidity',
                        total: devices.deviceTypes[0].total,
                      ),
                      DeviceTypeCard(
                        icon: MdiIcons.thermometer,
                        color: Colors.red,
                        title: 'Temperature',
                        total: devices.deviceTypes[1].total,
                      ),
                      DeviceTypeCard(
                        icon: MdiIcons.lightbulbOn,
                        color: Colors.yellow[800],
                        title: 'LDR',
                        total: devices.deviceTypes[2].total,
                      ),
                      DeviceTypeCard(
                        icon: MdiIcons.waves,
                        color: Colors.blue,
                        title: 'Flow',
                        total: devices.deviceTypes[3].total,
                      ),
                      DeviceTypeCard(
                        icon: MdiIcons.waterAlertOutline,
                        color: Colors.purple,
                        title: 'pH',
                        total: devices.deviceTypes[4].total,
                      ),
                    ],
                  ),
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
