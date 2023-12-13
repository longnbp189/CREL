// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Industry _$IndustryFromJson(Map<String, dynamic> json) => Industry(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
    };
