// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renewable_share_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RenewableShareResponse _$RenewableShareResponseFromJson(Map json) =>
    RenewableShareResponse(
      unixSeconds: (json['unix_seconds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      forecast: (json['forecast'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      deprecated: json['deprecated'] as bool,
    );

Map<String, dynamic> _$RenewableShareResponseToJson(
  RenewableShareResponse instance,
) => <String, dynamic>{
  'unix_seconds': instance.unixSeconds,
  'data': instance.data,
  'forecast': instance.forecast,
  'deprecated': instance.deprecated,
};
