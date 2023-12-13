// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ward _$WardFromJson(Map<String, dynamic> json) => Ward(
      id: json['id'] as int?,
      districtId: json['districtId'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      teamId: json['teamId'] as int?,
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'id': instance.id,
      'districtId': instance.districtId,
      'name': instance.name,
      'status': instance.status,
      'teamId': instance.teamId,
      'district': instance.district?.toJson(),
    };
