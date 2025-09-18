import 'package:json_annotation/json_annotation.dart';

part 'total_power_request.g.dart';

/// A data model for the TotalPowerRequest.
@JsonSerializable(fieldRename: FieldRename.snake)
class TotalPowerRequest {
  TotalPowerRequest({
    required this.country,
    this.start,
    this.end,
  });

  factory TotalPowerRequest.fromJson(Map<String, dynamic> json) =>
      _$TotalPowerRequestFromJson(json);

  final String country;
  /// Start and End have to be DateTime ms since epoch.
  String? start;
  String? end;

  Map<String, dynamic> toJson() => _$TotalPowerRequestToJson(this);
}
