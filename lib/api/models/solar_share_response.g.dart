// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_share_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolarShareResponse _$SolarShareResponseFromJson(Map<String, dynamic> json) =>
    SolarShareResponse(
      unixSeconds: (json['unix_seconds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      forecast: (json['forecast'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      deprecated: json['deprecated'] as bool,
    );

Map<String, dynamic> _$SolarShareResponseToJson(SolarShareResponse instance) =>
    <String, dynamic>{
      'unix_seconds': instance.unixSeconds,
      'data': instance.data,
      'forecast': instance.forecast,
      'deprecated': instance.deprecated,
    };
