// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceResponse _$PriceResponseFromJson(Map<String, dynamic> json) =>
    PriceResponse(
      licenseInfo: json['license_info'] as String,
      unixSeconds: (json['unix_seconds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      price: (json['price'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      unit: json['unit'] as String,
      deprecated: json['deprecated'] as bool,
    );

Map<String, dynamic> _$PriceResponseToJson(PriceResponse instance) =>
    <String, dynamic>{
      'license_info': instance.licenseInfo,
      'unix_seconds': instance.unixSeconds,
      'price': instance.price,
      'unit': instance.unit,
      'deprecated': instance.deprecated,
    };
