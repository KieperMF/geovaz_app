import 'package:flutter/cupertino.dart';
import 'package:geovaz_app/domain/dto/address_dto.dart';
import 'package:geovaz_app/domain/entity/address_entity.dart';
import 'package:geovaz_app/domain/mappers/address_mapper.dart';
import 'package:geovaz_app/geo_vaz_client.dart';
import 'package:geovaz_app/service_locator.dart';
import 'package:latlong2/latlong.dart';
import 'package:result_dart/result_dart.dart';

class GeoVazService {
  final _client = sl<GeoVazClient>();

  AsyncResult<AddressEntity> getAddressFromLatLng({required LatLng position}) {
    final response = _client.get(
      "https://nominatim.openstreetmap.org/reverse?"
      "lat=${position.latitude}&lon=${position.longitude}&format=json&addressdetails=1",
      headers: {'User-Agent': 'GeoVaz/1.0 (kiepermatheus07@gmail.com)'},
    );
    return response.fold((onSuccess) {
      debugPrint('${onSuccess.data}');
      return Success(AddressDto.fromJson(onSuccess.data['address']).toEntity());
    }, (onError) => Failure(onError));
  }
}
