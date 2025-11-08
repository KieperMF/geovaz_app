// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => _AddressDto(
  city: json['city'] as String,
  state: json['state'] as String,
  country: json['country'] as String,
  road: json['road'] as String,
  house_number: json['house_number'] as String?,
  postcode: json['postcode'] as String?,
);

Map<String, dynamic> _$AddressDtoToJson(_AddressDto instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'road': instance.road,
      'house_number': instance.house_number,
      'postcode': instance.postcode,
    };
