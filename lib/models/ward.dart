import 'package:crel_mobile/models/district.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable(explicitToJson: true)
class Ward {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'districtId')
  final int? districtId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'teamId')
  final int? teamId;
  @JsonKey(name: 'district')
  final District? district;

  Ward(
      {this.id,
      this.districtId,
      this.name,
      this.status,
      this.teamId,
      this.district});

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$WardToJson(this);
}
