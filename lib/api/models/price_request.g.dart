// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRequest _$PriceRequestFromJson(Map<String, dynamic> json) => PriceRequest(
  bzn: json['bzn'] as String,
  start: json['start'] as String?,
  end: json['end'] as String?,
);

Map<String, dynamic> _$PriceRequestToJson(PriceRequest instance) =>
    <String, dynamic>{
      'bzn': instance.bzn,
      'start': instance.start,
      'end': instance.end,
    };
