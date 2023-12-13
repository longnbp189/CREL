// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as int?,
      brandId: json['brandId'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'name': instance.name,
      'address': instance.address,
    };
