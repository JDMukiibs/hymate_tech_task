// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_power_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalPowerResponse _$TotalPowerResponseFromJson(Map<String, dynamic> json) =>
    TotalPowerResponse(
      unixSeconds: (json['unix_seconds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      productionTypes: (json['production_types'] as List<dynamic>)
          .map((e) => ProductionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      deprecated: json['deprecated'] as bool,
    );

Map<String, dynamic> _$TotalPowerResponseToJson(TotalPowerResponse instance) =>
    <String, dynamic>{
      'unix_seconds': instance.unixSeconds,
      'production_types': instance.productionTypes,
      'deprecated': instance.deprecated,
    };

ProductionType _$ProductionTypeFromJson(Map<String, dynamic> json) =>
    ProductionType(
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$ProductionTypeToJson(ProductionType instance) =>
    <String, dynamic>{'name': instance.name, 'data': instance.data};
