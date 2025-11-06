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
      "https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json&addressdetails=1",
    );
    return response.fold(
      (onSuccess) =>
          Success(AddressDto.fromJson(onSuccess.data['Address']).toEntity()),
      (onError) => Failure(onError),
    );
  }
}
