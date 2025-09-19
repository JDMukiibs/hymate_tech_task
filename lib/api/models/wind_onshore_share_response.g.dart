// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_onshore_share_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindOnShoreShareResponse _$WindOnShoreShareResponseFromJson(
  Map<String, dynamic> json,
) => WindOnShoreShareResponse(
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

Map<String, dynamic> _$WindOnShoreShareResponseToJson(
  WindOnShoreShareResponse instance,
) => <String, dynamic>{
  'unix_seconds': instance.unixSeconds,
  'data': instance.data,
  'forecast': instance.forecast,
  'deprecated': instance.deprecated,
};
