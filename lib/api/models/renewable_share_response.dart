import 'package:json_annotation/json_annotation.dart';

part 'renewable_share_response.g.dart';

/// A unified data model for both solar and wind onshore renewable share
/// to reduce code duplication
@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true)
class RenewableShareResponse {
  RenewableShareResponse({
    required this.unixSeconds,
    required this.data,
    required this.forecast,
    required this.deprecated,
  });

  factory RenewableShareResponse.fromJson(Map<String, dynamic> json) =>
      _$RenewableShareResponseFromJson(json);

  final List<int> unixSeconds;
  final List<double?> data;
  final List<double?> forecast;
  final String unit = '%';
  final bool deprecated;

  Map<String, dynamic> toJson() => _$RenewableShareResponseToJson(this);
}
