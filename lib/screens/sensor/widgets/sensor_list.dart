import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/sensors.dart';
import 'package:sensor_app/screens/sensor/widgets/sensor_list_tile.dart';

class SensorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sensorsData = Provider.of<Sensors>(context);
    final sensors = sensorsData.sensors;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0,
        indent: 90.0,
        endIndent: 16.0,
        color: Color(0x40121212),
      ),
      itemCount: sensors.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: sensors[index],
        child: SensorListTile(),
      ),
    );
  }
}
