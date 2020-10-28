import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/models/sender_model.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/screens/sender/sender_detail_location.dart';
import 'package:sensor_app/screens/sender/widgets/sender_detail_tile.dart';
import 'package:sensor_app/utils/helper/date_formatter.dart';

class SenderDetailScreen extends StatelessWidget {
  static const String routeName = "sender_detail_screen";
  final senderId;

  SenderDetailScreen(this.senderId);

  @override
  Widget build(BuildContext context) {
    final sender =
        Provider.of<Senders>(context, listen: false).findById(senderId);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '${sender.name}',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              SenderDetailTile(title: 'Name', subtitle: sender.name),
              SenderDetailTile(title: 'Status', subtitle: sender.senderStatus),
              SenderDetailTile(
                title: 'Last Active',
                subtitle: DateFormatter.getVerboseDateTime(sender.lastActive),
              ),
              SenderDetailTile(
                title: 'Location',
                icon: Icons.chevron_right,
                onTap: () {
                  Navigator.pushNamed(context, SenderDetailLocation.routeName,
                      arguments: Coordinat(
                        lat: sender.coord.lat,
                        lon: sender.coord.lon,
                      ));
                },
              )
            ],
          ).toList(),
        ),
      ),
    );
  }
}
