import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable(explicitToJson: true)
class District {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'status')
  final int? status;

  District({
    this.id,
    this.name,
    this.status,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
