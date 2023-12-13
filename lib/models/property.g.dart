// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['id'] as int?,
      locationId: json['locationId'] as int?,
      brokerId: json['brokerId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      price: (json['price'] as num?)?.toDouble(),
      status: json['status'] as int?,
      description: json['description'] as String?,
      rejectReason: json['rejectReason'] as String?,
      type: json['type'] as int?,
      name: json['name'] as String?,
      projectId: json['projectId'] as int?,
      direction: json['direction'] as int?,
      floor: json['floor'] as String?,
      floorArea: (json['floorArea'] as num?)?.toDouble(),
      frontage: (json['frontage'] as num?)?.toDouble(),
      certificates: json['certificates'] as int?,
      vertical: (json['vertical'] as num?)?.toDouble(),
      horizontal: (json['horizontal'] as num?)?.toDouble(),
      roadWidth: (json['roadWidth'] as num?)?.toDouble(),
      rentalCondition: json['rentalCondition'] as String?,
      rentalTerm: json['rentalTerm'] as String?,
      depositTerm: json['depositTerm'] as String?,
      paymentTerm: json['paymentTerm'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      owners: (json['owners'] as List<dynamic>?)
          ?.map((e) => Owner.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      area: (json['area'] as num?)?.toDouble(),
      project: json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>),
      numberOfFrontage: json['numberOfFrontage'] as int?,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'locationId': instance.locationId,
      'brokerId': instance.brokerId,
      'createDate': instance.createDate?.toIso8601String(),
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'status': instance.status,
      'price': instance.price,
      'description': instance.description,
      'rejectReason': instance.rejectReason,
      'type': instance.type,
      'name': instance.name,
      'projectId': instance.projectId,
      'direction': instance.direction,
      'floor': instance.floor,
      'floorArea': instance.floorArea,
      'frontage': instance.frontage,
      'area': instance.area,
      'certificates': instance.certificates,
      'vertical': instance.vertical,
      'horizontal': instance.horizontal,
      'roadWidth': instance.roadWidth,
      'rentalCondition': instance.rentalCondition,
      'rentalTerm': instance.rentalTerm,
      'depositTerm': instance.depositTerm,
      'paymentTerm': instance.paymentTerm,
      'media': instance.media?.map((e) => e.toJson()).toList(),
      'owners': instance.owners?.map((e) => e.toJson()).toList(),
      'numberOfFrontage': instance.numberOfFrontage,
      'location': instance.location?.toJson(),
      'project': instance.project?.toJson(),
    };
