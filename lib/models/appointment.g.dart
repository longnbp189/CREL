// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as int?,
      brandId: json['brandId'] as int?,
      brokerId: json['brokerId'] as int?,
      onDateTime: json['onDateTime'] == null
          ? null
          : DateTime.parse(json['onDateTime'] as String),
      description: json['description'] as String?,
      status: json['status'] as int?,
      propertyId: json['propertyId'] as int?,
      createDateTime: json['createDateTime'] == null
          ? null
          : DateTime.parse(json['createDateTime'] as String),
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      rejectMessage: json['rejectMessage'] as String?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'brokerId': instance.brokerId,
      'propertyId': instance.propertyId,
      'onDateTime': instance.onDateTime?.toIso8601String(),
      'status': instance.status,
      'description': instance.description,
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'rejectMessage': instance.rejectMessage,
      'brand': instance.brand?.toJson(),
      'property': instance.property?.toJson(),
    };
