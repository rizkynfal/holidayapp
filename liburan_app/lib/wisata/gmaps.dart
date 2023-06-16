// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps(
      {Key? key,
      required this.title,
      required this.latitude,
      required this.longitude})
      : super(key: key);
  final String title;
  final double latitude, longitude;
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController? mapsController;
  late double _latitude = widget.latitude;
  late double _longitude = widget.longitude;
  late LatLng showLocation = LatLng(_latitude, _longitude);
  void _mapCreated(GoogleMapController _mapsController) {
    mapsController = _mapsController;
  }

  late List<Location> locations;
  late List<Placemark> placemarks;
  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId(widget.title),
          position: showLocation,
          infoWindow: InfoWindow(title: widget.title),
          icon: BitmapDescriptor.defaultMarker,
          rotation: 0),
    };
  }

  @override
  void initState() {
    setState(() {
      _latitude = widget.latitude;
      _longitude = widget.longitude;
      showLocation = LatLng(_latitude, _longitude);
    });

    //you can add more markers here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          markers: _createMarker(),
          onMapCreated: _mapCreated,
          onTap: (latLng) async {
            placemarks = await placemarkFromCoordinates(_latitude, _longitude);
          },
          onLongPress: (latLng) async {
            locations = await locationFromAddress(widget.title);
          },
          initialCameraPosition: CameraPosition(
            target: showLocation,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
