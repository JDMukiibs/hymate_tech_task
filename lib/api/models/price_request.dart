import 'package:json_annotation/json_annotation.dart';

part 'price_request.g.dart';

/// A data model for the PriceRequest.
@JsonSerializable(fieldRename: FieldRename.snake)
class PriceRequest {
  PriceRequest({
    required this.bzn,
    this.start,
    this.end,
  });

  factory PriceRequest.fromJson(Map<String, dynamic> json) =>
      _$PriceRequestFromJson(json);

  final String bzn;
  /// Start and End have to be DateTime ms since epoch.
  String? start;
  String? end;

  Map<String, dynamic> toJson() => _$PriceRequestToJson(this);
}
