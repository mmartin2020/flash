
   
import 'dart:async';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

late LatLng _initialPositon =LatLng(-33.4436491,-70.6644089);

Future<LatLng> _getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted)
      throw 'No GPS permissions';
  }
  final LocationData data = await location.getLocation();
  return LatLng(data.latitude!, data.longitude!);
}


class Position extends StatefulWidget {
  @override
  _PositionState createState() => _PositionState();
}

class _PositionState extends State<Position> {
  late final GoogleMapController _controller;

  final origCtrl = TextEditingController();

  final destCtrl = TextEditingController();

  final polylines = Set<Polyline>();

  final markers = Set<Marker>();

  final geoMethods = GeoMethods(
    /// [Get API key](https://developers.google.com/maps/documentation/embed/get-api-key)
    googleApiKey: 'AIzaSyAvigvXM1OWxMRU3ZGZv0ImXsqNGUJrjnU',
    language: 'es-419',
    countryCode: 'ec',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     
      body: Column(
        children: [
          Text('Direccíon de despacho'),
          SizedBox(height: 20.0,),
          Expanded(
            child: GoogleMap(
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _initialPositon,
                zoom: 14.5,
              ),
              onMapCreated: (GoogleMapController controller) =>
                  _controller = controller,
              polylines: polylines,
              markers: markers,
            ),
          ),
          RouteSearchBox(
            geoMethods: geoMethods,
            originCtrl: origCtrl,
            destinationCtrl: destCtrl,
            builder: (context, originBuilder, destinationBuilder,
                waypointBuilder, waypointsMgr, relocate, getDirections) {
              if (origCtrl.text.isEmpty)
                relocate(AddressId.origin, _initialPositon.toCoords());
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                color: Colors.green[50],
                height: 150.0,
                child: Column(
                  children: [
                    TextField(
                      controller: origCtrl,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => originBuilder.buildDefault(
                          builder: AddressDialogBuilder(hintText: 'Ingresa dirección',cancelText: 'Cancelar', ),
                          onDone: (address) => null,
                        ),
                      ),
                    ),
                    TextField(
                      controller: destCtrl,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => destinationBuilder.buildDefault(
                          builder: AddressDialogBuilder(hintText:'Ingresa dirección',cancelText: 'Cancelar',),
                          onDone: (address) => null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            child: Icon(Icons.point_of_sale),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (_) =>
                                    Waypoints(waypointsMgr, waypointBuilder),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.replay_outlined),
                            onPressed: () async => relocate(AddressId.origin,
                                (await _getPosition()).toCoords()),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.search),
                            onPressed: () async {
                              try {
                                final result = await getDirections();
                                markers.clear();
                                polylines.clear();
                                markers.addAll([
                                  Marker(
                                      markerId: MarkerId('origin'),
                                      position: result.origin.coords!),
                                  Marker(
                                      markerId: MarkerId('dest'),
                                      position: result.destination.coords!)
                                ]);
                                result.waypoints.asMap().forEach((key, value) =>
                                    markers.add(Marker(
                                        markerId: MarkerId('point$key'),
                                        position: value.coords!)));
                                polylines.add(Polyline(
                                  polylineId: PolylineId('result'),
                                  points: result.points,
                                  color: Colors.blue,
                                  width: 5,
                                ));
                                setState(() {});
                                await _controller.animateCamera(
                                    CameraUpdate.newLatLngBounds(
                                        result.bounds, 60.0));
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Waypoints extends StatelessWidget {
  const Waypoints(this.waypointsMgr, this.waypointBuilder);

  final WaypointsManager waypointsMgr;
  final AddressSearchBuilder waypointBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add_location_alt),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => waypointBuilder.buildDefault(
                builder: AddressDialogBuilder(),
                onDone: (address) => null,
              ),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder<List<Address>>(
        valueListenable: waypointsMgr.valueNotifier,
        builder: (context, value, _) => ListView.separated(
          itemCount: value.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) =>
              ListTile(title: Text(value[index].reference!)),
        ),
      ),
    );
  }
}
