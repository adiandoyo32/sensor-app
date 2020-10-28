import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/screens/widgets/listtile/reuseable_list_tile.dart';

class SenderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sendersData = Provider.of<Senders>(context);
    final senders = sendersData.senders;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0,
        indent: 90.0,
        endIndent: 16.0,
        color: Color(0x40121212),
      ),
      itemCount: senders.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: senders[index],
        child: ReusableListTile(),
      ),
    );
  }
}
