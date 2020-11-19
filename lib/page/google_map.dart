import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final String locationName;
  final double latitude;
  final double longitude;
  MapPage({
    this.locationName,
    this.latitude,
    this.longitude
  });
  @override
  _GoogleMapState createState() => _GoogleMapState(locationName: locationName, latitude:latitude, longitude:longitude);
}

class _GoogleMapState extends State<MapPage> {
  final String locationName;
  final double latitude;
  final double longitude;

  _GoogleMapState({
    this.locationName,
    this.latitude,
    this.longitude
  });
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final CameraPosition _initPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17.5);
    return Scaffold(
      appBar: AppBar(
        title: Text("『" + locationName + "』の周辺"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId('marker_1'),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(title: locationName, snippet: "あいうえおかきくけこさしすせそたちつてと"),
            ));
          });
        },
        minMaxZoomPreference: MinMaxZoomPreference(16, 18),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
