import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_dto.freezed.dart';
part 'address_dto.g.dart';

@freezed
sealed class AddressDto with _$AddressDto {
  const factory AddressDto({
    required String city,
    required String state,
    required String country,
    required String road,
    required String? house_number,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
}
