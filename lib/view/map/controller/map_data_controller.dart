import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geovaz_app/domain/entity/address_entity.dart';
import 'package:geovaz_app/domain/repositories/geo_vaz_repository.dart';
import 'package:geovaz_app/service_locator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapDataController {
  final _respository = sl<GeoVazRepository>();
  MapController mapController = MapController();
  Location location = Location();
  PermissionStatus? permissionStatus;
  LocationData? locationData;
  bool serviceEnabled = false;
  final ValueNotifier<LatLng?> currentPosition = ValueNotifier(null);
  AddressEntity address = AddressEntity.empty();

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

  Future<void> getAddressFromLatLng(LatLng position) async {
    final result = await _respository.getAddressFromLatLng(position: position);
    result.fold((onSuccess) {
      address = onSuccess;
    }, (onFailure) {});
  }
}
