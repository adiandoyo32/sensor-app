import 'package:flutter/foundation.dart';

class Sender with ChangeNotifier {
  final int id, status;
  final String name;
  final Coordinat coord;
  final DateTime lastActive;

  Sender({
    this.id,
    this.name,
    this.coord,
    this.status,
    this.lastActive,
  });

  String get senderStatus {
    return status == 1 ? 'Active' : 'Deactive';
  }

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      coord: Coordinat.fromJson(json['coord']),
      lastActive: DateTime.parse(json['last_active']),
    );
  }

  @override
  String toString() =>
      'Sender { id: $id, name: $name, status: $status, coord: $coord }';
}

class Coordinat {
  final double lat, lon;

  Coordinat({
    this.lat = 0,
    this.lon = 0,
  });

  factory Coordinat.fromJson(Map<String, dynamic> json) {
    return Coordinat(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  @override
  String toString() => 'Coordinat { lat: $lat, lon: $lon }';
}
