// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_manager_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaManagerTeam _$AreaManagerTeamFromJson(Map<String, dynamic> json) =>
    AreaManagerTeam(
      id: json['id'] as int?,
      teamId: json['teamId'] as int?,
      areaManagerId: json['areaManagerId'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$AreaManagerTeamToJson(AreaManagerTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'areaManagerId': instance.areaManagerId,
    };
