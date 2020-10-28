import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/models/sensor_model.dart';
import 'package:sensor_app/providers/sensors.dart';

class SensorListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sensor = Provider.of<Sensor>(context, listen: false);
    return Dismissible(
      key: ValueKey(sensor.id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove this sensor?'),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Remove')),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Sensors>(context, listen: false).deleteSensor(sensor.id);
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
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 64,
            child: AspectRatio(
              aspectRatio: 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          '${sensor.name}',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${sensor.name}',
          style: TextStyle(color: kPrimaryColor),
        ),
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   SenderDetailScreen.routeName,
          //   arguments: sensor.id,
          // );
        },
      ),
    );
  }
}
