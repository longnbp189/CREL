// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestProperty _$SuggestPropertyFromJson(Map<String, dynamic> json) =>
    SuggestProperty(
      brandId: json['brandId'] as int?,
      propertyId: json['propertyId'] as int?,
      type: json['type'] as int?,
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuggestPropertyToJson(SuggestProperty instance) =>
    <String, dynamic>{
      'brandId': instance.brandId,
      'propertyId': instance.propertyId,
      'type': instance.type,
      'property': instance.property?.toJson(),
      'brand': instance.brand?.toJson(),
    };
