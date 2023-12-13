import 'package:json_annotation/json_annotation.dart';

part 'industry.g.dart';

@JsonSerializable(explicitToJson: true)
class Industry {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'status')
  final int? status;

  Industry({
    this.id,
    this.name,
    this.status,
  });

  factory Industry.fromJson(Map<String, dynamic> json) =>
      _$IndustryFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}
