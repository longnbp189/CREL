// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      industryId: json['industryId'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      avatarLink: json['avatarLink'] as String?,
      description: json['description'] as String?,
      status: json['status'] as int?,
      avatarFileId: json['avatarFileId'] as String?,
      firebaseUid: json['firebaseUid'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      rejectMessage: json['rejectMessage'] as String?,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'firebaseUid': instance.firebaseUid,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'description': instance.description,
      'rejectMessage': instance.rejectMessage,
      'avatarFileId': instance.avatarFileId,
      'avatarLink': instance.avatarLink,
      'industryId': instance.industryId,
      'registrationNumber': instance.registrationNumber,
      'stores': instance.stores?.map((e) => e.toJson()).toList(),
    };
