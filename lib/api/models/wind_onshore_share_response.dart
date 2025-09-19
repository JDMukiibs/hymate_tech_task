import 'package:json_annotation/json_annotation.dart';

part 'wind_onshore_share_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WindOnShoreShareResponse {
  WindOnShoreShareResponse({
    required this.unixSeconds,
    required this.data,
    required this.forecast,
    required this.deprecated,
  });

  factory WindOnShoreShareResponse.fromJson(Map<String, dynamic> json) =>
      _$WindOnShoreShareResponseFromJson(json);

  final List<int> unixSeconds;
  final List<double> data;
  final List<double> forecast;
  final bool deprecated;

  Map<String, dynamic> toJson() => _$WindOnShoreShareResponseToJson(this);
}
