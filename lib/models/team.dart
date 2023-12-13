import 'package:crel_mobile/models/area_manager_team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'areaManagerTeams')
  final List<AreaManagerTeam>? areaManagerTeams;

  Team({
    this.id,
    this.name,
    this.areaManagerTeams,
    this.status,
    this.description,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
