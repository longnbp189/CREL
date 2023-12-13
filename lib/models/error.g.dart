// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      statusCode: json['statusCode'] as int?,
      reasonPhrase: json['reasonPhrase'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'reasonPhrase': instance.reasonPhrase,
    };
