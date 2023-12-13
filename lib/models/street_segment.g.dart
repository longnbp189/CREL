// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreetSegment _$StreetSegmentFromJson(Map<String, dynamic> json) =>
    StreetSegment(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      districtId: json['districtId'] as int?,
    );

Map<String, dynamic> _$StreetSegmentToJson(StreetSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'districtId': instance.districtId,
    };
