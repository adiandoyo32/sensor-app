import 'package:flutter/foundation.dart';

class Sensor with ChangeNotifier {
  final int id, senderId;
  final String name;

  Sensor({this.id, this.senderId, this.name});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      name: json['name'],
      senderId: json['sender_id'],
    );
  }

  @override
  String toString() => 'Sensor { id: $id, name: $name, senderId: $senderId }';
}
