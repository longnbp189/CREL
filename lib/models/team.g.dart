// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as int?,
      name: json['name'] as String?,
      areaManagerTeams: (json['areaManagerTeams'] as List<dynamic>?)
          ?.map((e) => AreaManagerTeam.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'areaManagerTeams':
          instance.areaManagerTeams?.map((e) => e.toJson()).toList(),
    };
