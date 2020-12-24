import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/utils/helper/deviceType.dart';

class ValueCard extends StatelessWidget {
  const ValueCard({Key key, this.device}) : super(key: key);
  final Device device;

  @override
  Widget build(BuildContext context) {
    DeviceTypeModel type = DeviceTypeModel();
    return Container(
      height: 150.0,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              type.getIcon(device.deviceType.name),
              SizedBox(width: 8.0),
              Text(
                device.deviceType.name == "ph"
                    ? "pH Device"
                    : device.deviceType.name == "ldr"
                        ? "LDR Device"
                        : toBeginningOfSentenceCase(
                            "${device.deviceType.name} Device"),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Devices>(
                builder: (context, devices, _) => Center(
                  child: Text(
                    "${devices.deviceCurrentLog}",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Text(
                type.getSymbol(device.deviceType.name),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x338A959E),
            offset: Offset(0, 15),
            blurRadius: 35,
          ),
        ],
      ),
    );
  }
}
