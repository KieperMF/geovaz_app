import 'package:geovaz_app/domain/dto/address_dto.dart';
import 'package:geovaz_app/domain/entity/address_entity.dart';

extension AddressMapperDto on AddressDto {
  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      country: country,
      road: road,
      state: state,
      houseNumber: house_number ?? '',
      zipCode: postcode ?? '',
    );
  }
}
