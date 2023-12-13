// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int?,
      status: json['status'] as int?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      districtId: json['districtId'] as int?,
      handoverYear: json['handoverYear'] == null
          ? null
          : DateTime.parse(json['handoverYear'] as String),
      company: json['company'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'description': instance.description,
      'name': instance.name,
      'districtId': instance.districtId,
      'handoverYear': instance.handoverYear?.toIso8601String(),
      'company': instance.company,
      'media': instance.media?.map((e) => e.toJson()).toList(),
    };
