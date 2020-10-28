import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SenderPickLocation extends StatefulWidget {
  static const routeName = 'sender_pick_location';
  // final Coordinat initialLocation;
  final bool isSelecting;

  const SenderPickLocation({this.isSelecting = false});

  @override
  _SenderPickLocationState createState() => _SenderPickLocationState();
}

class _SenderPickLocationState extends State<SenderPickLocation> {
  // Completer<GoogleMapController> _controller = Completer();

  LatLng _initialPosition = LatLng(-0.03, 109.33);
  MapType _currentMapType = MapType.normal;
  String searchAddress;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  void updateLocation(LocationData locationData) {
    setState(() {
      _initialPosition = LatLng(locationData.latitude, locationData.longitude);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    // GoogleMapController _controller = controller;

    //   CameraPosition(
    //       target: LatLng(event.latitude, event.longitude), zoom: 15.0)
    // );
    // _location.onLocationChanged.listen((event) {
    //   _controller.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //         target: LatLng(event.latitude, event.longitude), zoom: 15.0),
    //   ));
    // });
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await Location().getLocation();
      setState(() {
        _initialPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);
      });
    } catch (e) {
      currentLocation = null;
    }
  }

  LatLng _pickLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickLocation = position;
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.white,
      child: Icon(
        icon,
        size: 36.0,
        color: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black87),
        title: Text(
          'Choose location on map',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black87,
              ),
              onPressed: _pickLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickLocation);
                    },
            )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 15.0),
            onTap: widget.isSelecting ? _selectLocation : null,
            markers: _pickLocation == null
                ? null
                : {
                    Marker(
                      markerId: MarkerId('m1'),
                      position: _pickLocation,
                    )
                  },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  SizedBox(height: 80.0),
                  button(_onMapTypeButtonPressed, Icons.layers),
                  // button(function, Icons.add_location),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
