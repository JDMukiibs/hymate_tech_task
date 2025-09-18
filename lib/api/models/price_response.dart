import 'package:json_annotation/json_annotation.dart';

part 'price_response.g.dart';

/// A data model for the PriceResponse.
@JsonSerializable(fieldRename: FieldRename.snake)
class PriceResponse {
  final String licenseInfo;
  final List<int> unixSeconds;
  final List<double> price;
  final String unit;
  final bool deprecated;

  PriceResponse({
    required this.licenseInfo,
    required this.unixSeconds,
    required this.price,
    required this.unit,
    required this.deprecated,
  });

  factory PriceResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceResponseToJson(this);
}
