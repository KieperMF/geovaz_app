import 'package:geovaz_app/domain/entity/address_entity.dart';
import 'package:latlong2/latlong.dart';
import 'package:result_dart/result_dart.dart';

abstract class GeoVazRepository {
  AsyncResult<AddressEntity> getAddressFromLatLng({required LatLng position});
}
