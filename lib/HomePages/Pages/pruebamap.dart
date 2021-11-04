import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pruebamap extends StatefulWidget {
  Pruebamap({Key? key}) : super(key: key);

  @override
  _PruebamapState createState() => _PruebamapState();
}

class _PruebamapState extends State<Pruebamap> {
  final _initialCameraPosition = CameraPosition(target: LatLng(0, 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
