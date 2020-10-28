import 'package:flutter/material.dart';
import 'package:sensor_app/models/sender_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SenderDetailLocation extends StatefulWidget {
  static const String routeName = "sender_detail_location";
  final Coordinat coord;

  const SenderDetailLocation(this.coord);

  @override
  _SenderDetailLocationState createState() => _SenderDetailLocationState();
}

class _SenderDetailLocationState extends State<SenderDetailLocation> {
  final Set<Marker> _markers = {};
  double lat, lng;

  @override
  void initState() {
    super.initState();

    lat = widget.coord.lat;
    lng = widget.coord.lon;

    _markers.add(
      Marker(
          markerId: MarkerId(widget.coord.lat.toString()),
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
