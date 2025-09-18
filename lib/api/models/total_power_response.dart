import 'package:json_annotation/json_annotation.dart';

part 'total_power_response.g.dart';

/// A data model for the TotalPowerResponse.
@JsonSerializable(fieldRename: FieldRename.snake)
class TotalPowerResponse {
  TotalPowerResponse({
    required this.unixSeconds,
    required this.productionTypes,
    required this.deprecated,
  });

  factory TotalPowerResponse.fromJson(Map<String, dynamic> json) =>
      _$TotalPowerResponseFromJson(json);
  final List<int> unixSeconds;
  final List<ProductionType> productionTypes;
  final bool deprecated;

  Map<String, dynamic> toJson() => _$TotalPowerResponseToJson(this);
}

/// A data model for the items within the production_types list.
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionType {
  ProductionType({
    required this.name,
    required this.data,
  });

  factory ProductionType.fromJson(Map<String, dynamic> json) =>
      _$ProductionTypeFromJson(json);
  final String name;
  final List<double> data;

  Map<String, dynamic> toJson() => _$ProductionTypeToJson(this);
}
