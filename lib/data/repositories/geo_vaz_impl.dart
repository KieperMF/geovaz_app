import 'package:geovaz_app/data/service/geo_vaz_service.dart';
import 'package:geovaz_app/domain/entity/address_entity.dart';
import 'package:geovaz_app/domain/repositories/geo_vaz_repository.dart';
import 'package:geovaz_app/service_locator.dart';
import 'package:latlong2/latlong.dart';
import 'package:result_dart/src/types.dart';

class GeoVazImpl implements GeoVazRepository {
  final _service = sl<GeoVazService>();

  @override
  AsyncResult<AddressEntity> getAddressFromLatLng({required LatLng position}) {
    return _service.getAddressFromLatLng(position: position);
  }
}
