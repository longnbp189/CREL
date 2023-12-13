// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Broker _$BrokerFromJson(Map<String, dynamic> json) => Broker(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      gender: json['gender'] as bool?,
      status: json['status'] as int?,
      teamId: json['teamId'] as int?,
      avatarFileId: json['avatarFileId'] as String?,
      avatarLink: json['avatarLink'] as String?,
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$BrokerToJson(Broker instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'birthday': instance.birthday?.toIso8601String(),
      'gender': instance.gender,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'teamId': instance.teamId,
      'avatarFileId': instance.avatarFileId,
      'avatarLink': instance.avatarLink,
      'team': instance.team?.toJson(),
    };
