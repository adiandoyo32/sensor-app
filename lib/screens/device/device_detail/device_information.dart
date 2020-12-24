import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sensor_app/models/coordinat_model.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/screens/device/device_detail_tile.dart';
import 'package:sensor_app/screens/device/device_location.dart';

class DeviceInformation extends StatelessWidget {
  const DeviceInformation({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            DeviceDetailTile(title: 'Name', subtitle: device.deviceId),
            DeviceDetailTile(title: 'Status', subtitle: device.deviceStatus),
            DeviceDetailTile(
                title: 'Device Type',
                subtitle: toBeginningOfSentenceCase(device.deviceType.name)),
            DeviceDetailTile(
              title: 'Location',
              icon: Icons.chevron_right,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DeviceLocation.routeName,
                  arguments: Coordinat(
                    lat: device.lat,
                    long: device.long,
                  ),
                );
              },
            )
          ],
        ).toList(),
      ),
    );
  }
}
