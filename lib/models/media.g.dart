// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      id: json['id'] as int?,
      link: json['link'] as String?,
      fileId: json['fileId'] as String?,
      propertyId: json['propertyId'] as int?,
      projectId: json['projectId'] as int?,
      type: json['type'] as int?,
      contractId: json['contractId'] as int?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'fileId': instance.fileId,
      'propertyId': instance.propertyId,
      'projectId': instance.projectId,
      'contractId': instance.contractId,
      'type': instance.type,
    };
