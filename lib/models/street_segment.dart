import 'package:json_annotation/json_annotation.dart';

part 'street_segment.g.dart';

@JsonSerializable(explicitToJson: true)
class StreetSegment {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'districtId')
  final int? districtId;

  StreetSegment({this.id, this.name, this.status, this.districtId});

  factory StreetSegment.fromJson(Map<String, dynamic> json) =>
      _$StreetSegmentFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$StreetSegmentToJson(this);
}
