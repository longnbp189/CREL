import 'package:json_annotation/json_annotation.dart';

part 'area_manager_team.g.dart';

@JsonSerializable(explicitToJson: true)
class AreaManagerTeam {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'teamId')
  final int? teamId;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  @JsonKey(name: 'areaManagerId')
  final int? areaManagerId;

  AreaManagerTeam({
    this.id,
    this.teamId,
    this.areaManagerId,
    this.startDate,
    this.endDate,
  });

  factory AreaManagerTeam.fromJson(Map<String, dynamic> json) =>
      _$AreaManagerTeamFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$AreaManagerTeamToJson(this);
}
