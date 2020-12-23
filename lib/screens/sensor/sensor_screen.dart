import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/sensors.dart';
import 'package:sensor_app/screens/sensor/sensor_add_screen.dart';
import 'package:sensor_app/screens/sensor/widgets/sensor_list.dart';
import 'package:sensor_app/services/sensor_service.dart';

class SensorScreen extends StatefulWidget {
  @override
  _SensorScreenState createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  // final _fireStore = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isLoading = true;
      Provider.of<Sensors>(context).fetchSensors().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refreshSensors(BuildContext context) async {
    await Provider.of<Sensors>(context, listen: false).fetchSensors();
  }

  // Stream<dynamic> getSensors() async {
  // final sensors = await _fireStore.collection('sensors').get();
  // for (var sensor in sensors.docs) {
  //   print(sensor.data);
  // }

  //   final sensors = SensorService().getFireSensor();
  //   return sensors;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      // body: StreamBuilder(
      //   stream: getSensors,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(child: Text('error'));
      //     } else if (snapshot.hasData) {
      //       return Center(child: Text('has data'));
      //     }
      //   },
      // ),
      body: RefreshIndicator(
        onRefresh: () => _refreshSensors(context),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
              child: Row(
                children: [
                  Consumer<Sensors>(
                    builder: (context, sensors, _) => RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "${sensors.sensorCount}  ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "sensors",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SensorList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, SensorAddScreen.routeName);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
          children: [
            TextSpan(text: "My "),
            TextSpan(
              text: "Sensor",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    );
  }
}
