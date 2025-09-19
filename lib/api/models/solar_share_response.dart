import 'package:json_annotation/json_annotation.dart';

part 'solar_share_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SolarShareResponse {
  SolarShareResponse({
    required this.unixSeconds,
    required this.data,
    required this.forecast,
    required this.deprecated,
  });

  factory SolarShareResponse.fromJson(Map<String, dynamic> json) =>
      _$SolarShareResponseFromJson(json);

  final List<int> unixSeconds;
  final List<double> data;
  final List<double> forecast;
  final bool deprecated;

  Map<String, dynamic> toJson() => _$SolarShareResponseToJson(this);
}
