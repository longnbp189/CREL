// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as int?,
      status: json['status'] as int?,
      placeId: json['placeId'] as String?,
      address: json['address'] as String?,
      wardId: json['wardId'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      streetSegment: json['streetSegment'] == null
          ? null
          : StreetSegment.fromJson(
              json['streetSegment'] as Map<String, dynamic>),
      ward: json['ward'] == null
          ? null
          : Ward.fromJson(json['ward'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'placeId': instance.placeId,
      'address': instance.address,
      'wardId': instance.wardId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'streetSegment': instance.streetSegment?.toJson(),
      'ward': instance.ward?.toJson(),
    };
