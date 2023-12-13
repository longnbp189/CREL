// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      id: json['id'] as int?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      ownerId: json['ownerId'] as int?,
      brandId: json['brandId'] as int?,
      brokerId: json['brokerId'] as int?,
      propertyId: json['propertyId'] as int?,
      status: json['status'] as int?,
      reasonCancel: json['reasonCancel'] as String?,
      lessor: json['lessor'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      paymentTerm: json['paymentTerm'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      contractTerms: (json['contractTerms'] as List<dynamic>?)
          ?.map((e) => ContractTerm.fromJson(e as Map<String, dynamic>))
          .toList(),
      brandRepresentativeAddress: json['brandRepresentativeAddress'] as String?,
      brandRepresentativeBirthday: json['brandRepresentativeBirthday'] == null
          ? null
          : DateTime.parse(json['brandRepresentativeBirthday'] as String),
      brandRepresentativeName: json['brandRepresentativeName'] as String?,
      brandRepresentativePhoneNumber:
          json['brandRepresentativePhoneNumber'] as String?,
      leaseLength: (json['leaseLength'] as num?)?.toDouble(),
      lessorAddress: json['lessorAddress'] as String?,
      lessorBank: json['lessorBank'] as String?,
      lessorBankAccountNumber: json['lessorBankAccountNumber'] as String?,
      lessorBirthDate: json['lessorBirthDate'] == null
          ? null
          : DateTime.parse(json['lessorBirthDate'] as String),
      lessorCccd: json['lessorCccd'] as String?,
      lessorCccdGrantAddress: json['lessorCccdGrantAddress'] as String?,
      lessorCccdGrantDate: json['lessorCccdGrantDate'] == null
          ? null
          : DateTime.parse(json['lessorCccdGrantDate'] as String),
      payDay: json['payDay'] as int?,
      registrationNumberGrantAddress:
          json['registrationNumberGrantAddress'] as String?,
      // registrationNumber: json['registrationNumber'] as String?,
      registrationNumberGrantDate: json['registrationNumberGrantDate'] == null
          ? null
          : DateTime.parse(json['registrationNumberGrantDate'] as String),
      renterOfficeAddress: json['renterOfficeAddress'] as String?,
      signAddress: json['signAddress'] as String?,
      signDate: json['signDate'] == null
          ? null
          : DateTime.parse(json['signDate'] as String),
      brandRepresentativeCccdGrantAddress:
          json['brandRepresentativeCccdGrantAddress'] as String?,
      brandRepresentativeCccd: json['brandRepresentativeCccd'] as String?,
      brandRepresentativeCccdGrantDate:
          json['brandRepresentativeCccdGrantDate'] == null
              ? null
              : DateTime.parse(json['registrationNumberGrantDate'] as String),
      handoverDate: json['handoverDate'] == null
          ? null
          : DateTime.parse(json['handoverDate'] as String),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'ownerId': instance.ownerId,
      'propertyId': instance.propertyId,
      'brandId': instance.brandId,
      'brokerId': instance.brokerId,
      'status': instance.status,
      'reasonCancel': instance.reasonCancel,
      'lessor': instance.lessor,
      'createDate': instance.createDate?.toIso8601String(),
      'paymentTerm': instance.paymentTerm,
      'price': instance.price,
      'media': instance.media?.map((e) => e.toJson()).toList(),
      'brand': instance.brand?.toJson(),
      'property': instance.property?.toJson(),
      'owner': instance.owner?.toJson(),
      'signDate': instance.signDate?.toIso8601String(),
      'signAddress': instance.signAddress,
      'lessorBirthDate': instance.lessorBirthDate?.toIso8601String(),
      'lessorCccd': instance.lessorCccd,
      'lessorCccdGrantDate': instance.lessorCccdGrantDate?.toIso8601String(),
      'lessorCccdGrantAddress': instance.lessorCccdGrantAddress,
      'lessorAddress': instance.lessorAddress,
      'lessorBankAccountNumber': instance.lessorBankAccountNumber,
      'lessorBank': instance.lessorBank,
      'renterOfficeAddress': instance.renterOfficeAddress,
      'registrationNumberGrantDate':
          instance.registrationNumberGrantDate?.toIso8601String(),
      'registrationNumberGrantAddress': instance.registrationNumberGrantAddress,
      // 'registrationNumber': instance.registrationNumber,
      'brandRepresentativeName': instance.brandRepresentativeName,
      'brandRepresentativeBirthday':
          instance.brandRepresentativeBirthday?.toIso8601String(),
      'brandRepresentativeAddress': instance.brandRepresentativeAddress,
      'brandRepresentativeCccd': instance.brandRepresentativeCccd,
      'brandRepresentativePhoneNumber': instance.brandRepresentativePhoneNumber,
      'brandRepresentativeCccdGrantDate':
          instance.brandRepresentativeCccdGrantDate?.toIso8601String(),
      'brandRepresentativeCccdGrantAddress':
          instance.brandRepresentativeCccdGrantAddress,
      'payDay': instance.payDay,
      'leaseLength': instance.leaseLength,
      'handoverDate': instance.handoverDate?.toIso8601String(),
      'contractTerms': instance.contractTerms?.map((e) => e.toJson()).toList(),
    };
