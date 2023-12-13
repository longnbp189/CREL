import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(explicitToJson: true)
class Error {
  @JsonKey(name: 'statusCode')
  final int? statusCode;
  @JsonKey(name: 'reasonPhrase')
  final String? reasonPhrase;

  Error({this.statusCode, this.reasonPhrase});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
