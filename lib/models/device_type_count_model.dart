import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DeviceTypeCount with ChangeNotifier {
  final String code, name;
  final int total;

  DeviceTypeCount({
    this.code = "",
    this.name = "",
    this.total = 0,
  });

  String get typeName {
    return name == 'ph'
        ? 'pH'
        : name == 'ldr' ? 'LDR' : toBeginningOfSentenceCase(name);
  }

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
