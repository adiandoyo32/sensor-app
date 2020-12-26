import 'package:flutter/material.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/device/device_detail/widgets/device_chart.dart';
import 'package:sensor_app/screens/device/device_detail/widgets/value_card.dart';

class DeviceStatistic extends StatefulWidget {
  const DeviceStatistic({Key key, @required this.device}) : super(key: key);
  final Device device;

  @override
  _DeviceStatisticState createState() => _DeviceStatisticState();
}

class _DeviceStatisticState extends State<DeviceStatistic> {
  @override
  Widget build(BuildContext context) {
    PusherOptions options = PusherOptions(
      host: 'api.sensorku.tafexclusive.site',
      port: 6001,
      encrypted: false,
    );

    FlutterPusher pusher =
        FlutterPusher('sensorku', options, enableLogging: false);

    Echo echo = new Echo({
      'broadcaster': 'pusher',
      'client': pusher,
    });

    echo.channel('log.${widget.device.deviceId}').listen('NewLog', (e) {
      final device = Provider.of<Devices>(context, listen: false);
      device.setDeviceCurrentLog(e['value']);
      device.addData(e);
    });

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueCard(device: widget.device),
            SizedBox(height: 16.0),
            DeviceChart(),
            // SimpleLineChart.withSampleData(),
          ],
        ),
      ),
    );
  }
}
