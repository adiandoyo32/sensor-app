import 'package:flutter/foundation.dart';

class Sensor with ChangeNotifier {
  final int id, sensorId;
  final String name;

  Sensor({this.id, this.sensorId, this.name});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      name: json['name'],
      sensorId: json['sensor_id'],
    );
  }

  @override
  String toString() => 'Sensor { id: $id, name: $name, status: $sensorId }';
}
