import 'package:flutter/material.dart';

class SenderDetailTile extends StatelessWidget {
  const SenderDetailTile({
    Key key,
    @required this.title,
    this.subtitle = '',
    this.icon,
    this.onTap,
  }) : super(key: key);

  final String title, subtitle;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != '' ? Text(subtitle) : null,
        trailing: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
