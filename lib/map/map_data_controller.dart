import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapDataController {
  MapController mapController = MapController();
  Location location = Location();
  PermissionStatus? permissionStatus;
  LocationData? locationData;
  bool serviceEnabled = false;
  final ValueNotifier<LatLng?> currentPosition = ValueNotifier(null);

  initLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    if (permissionStatus != PermissionStatus.granted) return;
    locationData = await location.getLocation();
    final LatLng position = LatLng(-20.317737542423362, -40.32194497842888);
    currentPosition.value = position;

    mapController.move(position, 16);
  }
}
