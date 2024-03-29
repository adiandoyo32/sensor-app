import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Device with ChangeNotifier {
  final int id, isActive;
  final double lat, long;
  final String deviceId, senderId, sensorId;
  final DeviceType deviceType;

  Device(
      {this.id,
      this.deviceId,
      this.senderId,
      this.sensorId,
      this.lat,
      this.long,
      this.isActive,
      this.deviceType});

  String get deviceStatus {
    return isActive == 1 ? 'Active' : 'Inactive';
  }

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      deviceId: json['device_id'],
      senderId: json['sender_id'],
      sensorId: json['sensor_id'],
      isActive: json['is_active'],
      lat: json['lat'] as double,
      long: json['long'] as double,
      deviceType: DeviceType.fromJson(json['device_type']),
    );
  }

  @override
  String toString() =>
      'Device { id: $id, device: $deviceId, status: $isActive, lat: $lat, long: $long type: $deviceType }';
}

class DeviceType {
  final String code, name;

  DeviceType({
    this.code = "",
    this.name = "",
  });

  String get typeName {
    return name == 'ph'
        ? 'pH'
        : name == 'ldr' ? 'LDR' : toBeginningOfSentenceCase(name);
  }

  factory DeviceType.fromJson(Map<String, dynamic> json) {
    return DeviceType(
      code: json['code'],
      name: json['name'],
    );
  }

  @override
  String toString() => 'DeviceType { code: $code, name: $name }';
}
