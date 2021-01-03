import 'package:flutter/foundation.dart';

class DeviceTypeCount with ChangeNotifier {
  final String code, name;
  final int total;

  DeviceTypeCount({
    this.code = "",
    this.name = "",
    this.total = 0,
  });

  factory DeviceTypeCount.fromJson(Map<String, dynamic> json) {
    return DeviceTypeCount(
      code: json['type_code'],
      name: json['type_name'],
      total: json['total'],
    );
  }

  @override
  String toString() =>
      'DeviceTypeCount { code: $code, name: $name, total: $total }';
}
