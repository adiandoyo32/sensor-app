import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/device/device_detail/device_detail_screen.dart';
import 'package:sensor_app/utils/helper/deviceType.dart';

class ReusableListTile extends StatelessWidget {
  final DeviceTypeModel type = DeviceTypeModel();

  @override
  Widget build(BuildContext context) {
    final device = Provider.of<Device>(context, listen: false);
    return Dismissible(
      key: ValueKey(device.id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Confirmation'),
            content: Text('Do you want to remove this device?'),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Remove')),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Devices>(context, listen: false).deleteDevice(device.id);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 32.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 64,
            child: AspectRatio(
              aspectRatio: 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: type.getColor(device.deviceType.name),
                  child: type.getIcon(device.deviceType.name),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          '${device.deviceId}',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${device.deviceStatus}',
          style: TextStyle(
            color:
                device.deviceStatus == 'Active' ? kPrimaryColor : kErrorColor,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            DeviceDetailScreen.routeName,
            arguments: device.id,
          );
        },
      ),
    );
  }
}
