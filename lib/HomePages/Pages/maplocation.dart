import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Position extends StatefulWidget {
  Position({Key? key}) : super(key: key);

  @override
  _PositionState createState() => _PositionState();
}

class _PositionState extends State<Position> {
  final _initialCameraPosition =
      CameraPosition(target: LatLng(-33.4432923, -70.6650268), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        mapToolbarEnabled: false,
        onTap: (location) {
          print(location);
        },
      ),
    );
  }
}
