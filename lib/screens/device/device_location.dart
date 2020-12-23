import 'package:flutter/material.dart';
import 'package:sensor_app/models/coordinat_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceLocation extends StatefulWidget {
  static const String routeName = "device_location";
  final Coordinat coordinat;

  const DeviceLocation(this.coordinat);

  @override
  _DeviceLocationState createState() => _DeviceLocationState();
}

class _DeviceLocationState extends State<DeviceLocation> {
  final Set<Marker> _markers = {};
  double lat, lng;

  @override
  void initState() {
    super.initState();
    lat = widget.coordinat.lat;
    lng = widget.coordinat.long;

    _markers.add(
      Marker(
          markerId: MarkerId(widget.coordinat.lat.toString()),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarker),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12.0,
        ),
        markers: _markers,
      ),
    );
  }
}
