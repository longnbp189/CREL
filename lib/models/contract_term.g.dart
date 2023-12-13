// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractTerm _$ContractTermFromJson(Map<String, dynamic> json) => ContractTerm(
      index: json['index'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      contractTerms: (json['contractTerms'] as List<dynamic>?)
          ?.map((e) => ContractTerm.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContractTermToJson(ContractTerm instance) =>
    <String, dynamic>{
      'index': instance.index,
      'title': instance.title,
      'content': instance.content,
      'contractTerms': instance.contractTerms?.map((e) => e.toJson()).toList(),
    };
