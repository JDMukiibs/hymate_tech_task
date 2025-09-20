// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlotRequest _$PlotRequestFromJson(Map<String, dynamic> json) => PlotRequest(
  id: json['id'] as String,
  name: json['name'] as String,
  data: PlotRequestData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlotRequestToJson(PlotRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };

PlotRequestData _$PlotRequestDataFromJson(Map<String, dynamic> json) =>
    PlotRequestData(
      datapoints: (json['datapoints'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      extra: (json['extra'] as List<dynamic>?)
          ?.map((e) => PlotRequestExtraData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlotRequestDataToJson(PlotRequestData instance) =>
    <String, dynamic>{
      'datapoints': instance.datapoints,
      'extra': instance.extra,
    };

PlotRequestExtraData _$PlotRequestExtraDataFromJson(
  Map<String, dynamic> json,
) => PlotRequestExtraData(
  datapoints: (json['datapoints'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  label: json['label'] as String,
  operation: json['operation'] as String? ?? 'sum',
);

Map<String, dynamic> _$PlotRequestExtraDataToJson(
  PlotRequestExtraData instance,
) => <String, dynamic>{
  'operation': instance.operation,
  'datapoints': instance.datapoints,
  'label': instance.label,
};
