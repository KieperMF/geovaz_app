import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geovaz_app/domain/entity/address_entity.dart';
import 'package:geovaz_app/domain/repositories/geo_vaz_repository.dart';
import 'package:geovaz_app/service_locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class DataController {
  final _respository = sl<GeoVazRepository>();
  MapController mapController = MapController();
  Location location = Location();
  PermissionStatus? permissionStatus;
  LocationData? locationData;
  bool serviceEnabled = false;
  final ValueNotifier<LatLng?> currentPosition = ValueNotifier(null);
  ValueNotifier<AddressEntity> address = ValueNotifier(AddressEntity.empty());
  String customerName = '';
  String customerEmail = '';
  String customerPhone = '';
  ValueNotifier<XFile?> userImage = ValueNotifier(null);

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
    result.fold(
      (onSuccess) {
        debugPrint('succes ${onSuccess.city})}');
        address.value = onSuccess;
      },
      (onFailure) {
        if (onFailure is DioException) {
          final message = onFailure.response!.statusMessage;
          debugPrint('exception:  $message');
          return;
        }
        debugPrint('Error ${onFailure.toString()}');
      },
    );
  }
}
