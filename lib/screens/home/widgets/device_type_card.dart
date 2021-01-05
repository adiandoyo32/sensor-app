import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/models/device_type_count_model.dart';
import 'package:sensor_app/utils/helper/deviceType.dart';
import 'package:sensor_app/providers/navigation.dart';
import 'package:sensor_app/providers/devices.dart';

class DeviceTypeCard extends StatelessWidget {
  final DeviceTypeModel deviceTypeModel = DeviceTypeModel();

  @override
  Widget build(BuildContext context) {
    final deviceType = Provider.of<DeviceTypeCount>(context, listen: false);
    final navigation = Provider.of<Navigation>(context, listen: false);
    final device = Provider.of<Devices>(context, listen: false);
    return GestureDetector(
      onTap: () {
        navigation.currentIndex = 1;
        device.setFilterStatus("All");
        device.setFilterType(deviceType.typeName);
        device.filterDevice();
      },
      child: Material(
        child: Container(
          width: 155,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
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
            children: [
              SizedBox(width: 24.0),
              deviceTypeModel.getIcon(deviceType.name),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    deviceType.name == 'ph'
                        ? 'pH'
                        : deviceType.name == 'ldr'
                            ? 'LDR'
                            : toBeginningOfSentenceCase(deviceType.name),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(text: '${deviceType.total} '),
                        TextSpan(
                          text: deviceType.total > 1 ? 'devices' : 'device',
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
