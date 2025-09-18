// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_power_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalPowerRequest _$TotalPowerRequestFromJson(Map<String, dynamic> json) =>
    TotalPowerRequest(
      country: json['country'] as String,
      start: json['start'] as String?,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$TotalPowerRequestToJson(TotalPowerRequest instance) =>
    <String, dynamic>{
      'country': instance.country,
      'start': instance.start,
      'end': instance.end,
    };
