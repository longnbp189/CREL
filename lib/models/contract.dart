import 'package:crel_mobile/models/contract_term.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract.g.dart';

@JsonSerializable(explicitToJson: true)
class Contract {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'startDate')
  DateTime? startDate;
  @JsonKey(name: 'endDate')
  DateTime? endDate;
  @JsonKey(name: 'ownerId')
  final int? ownerId;
  @JsonKey(name: 'propertyId')
  final int? propertyId;
  @JsonKey(name: 'brandId')
  final int? brandId;
  @JsonKey(name: 'brokerId')
  final int? brokerId;
  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'reasonCancel')
  final String? reasonCancel;
  @JsonKey(name: 'createDate')
  DateTime? createDate;
  @JsonKey(name: 'paymentTerm')
  final String? paymentTerm;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'media')
  final List<Media>? media;
  @JsonKey(name: 'brand')
  final Brand? brand;
  @JsonKey(name: 'property')
  Property? property;
  @JsonKey(name: 'owner')
  final Owner? owner;

  @JsonKey(name: 'signDate')
  final DateTime? signDate;
  @JsonKey(name: 'signAddress')
  final String? signAddress;
  @JsonKey(name: 'lessor')
  final String? lessor;
  // @JsonKey(name: 'lessorName')
  // final String? lessorName;
  @JsonKey(name: 'lessorBirthDate')
  final DateTime? lessorBirthDate;
  @JsonKey(name: 'lessorCccd')
  final String? lessorCccd;
  @JsonKey(name: 'lessorCccdGrantDate')
  final DateTime? lessorCccdGrantDate;
  @JsonKey(name: 'lessorCccdGrantAddress')
  final String? lessorCccdGrantAddress;
  @JsonKey(name: 'lessorAddress')
  final String? lessorAddress;
  // @JsonKey(name: 'lessorPhoneNumber')
  // final String? lessorPhoneNumber;
  @JsonKey(name: 'lessorBankAccountNumber')
  final String? lessorBankAccountNumber;
  @JsonKey(name: 'lessorBank')
  final String? lessorBank;
  // @JsonKey(name: 'address')
  // final String? address;
  // @JsonKey(name: 'renter')
  // final String? renter;
  @JsonKey(name: 'renterOfficeAddress')
  final String? renterOfficeAddress;
  // @JsonKey(name: 'registrationNumber')
  // final String? registrationNumber;
  @JsonKey(name: 'registrationNumberGrantDate')
  final DateTime? registrationNumberGrantDate;
  @JsonKey(name: 'registrationNumberGrantAddress')
  final String? registrationNumberGrantAddress;
  @JsonKey(name: 'brandRepresentativeName')
  final String? brandRepresentativeName;
  @JsonKey(name: 'brandRepresentativeBirthday')
  final DateTime? brandRepresentativeBirthday;
  @JsonKey(name: 'brandRepresentativeAddress')
  final String? brandRepresentativeAddress;
  @JsonKey(name: 'brandRepresentativePhoneNumber')
  final String? brandRepresentativePhoneNumber;
  @JsonKey(name: 'brandRepresentativeCccd')
  final String? brandRepresentativeCccd;
  @JsonKey(name: 'brandRepresentativeCccdGrantDate')
  final DateTime? brandRepresentativeCccdGrantDate;
  @JsonKey(name: 'brandRepresentativeCccdGrantAddress')
  final String? brandRepresentativeCccdGrantAddress;
  // @JsonKey(name: 'area')
  // final double? area;
  // @JsonKey(name: 'priceInText')
  // final String? priceInText;
  @JsonKey(name: 'payDay')
  final int? payDay;
  @JsonKey(name: 'leaseLength')
  final double? leaseLength;
  @JsonKey(name: 'handoverDate')
  final DateTime? handoverDate;
  @JsonKey(name: 'contractTerms')
  final List<ContractTerm>? contractTerms;

  Contract(
      {this.id,
      this.startDate,
      this.endDate,
      this.ownerId,
      this.brandId,
      this.brokerId,
      this.propertyId,
      this.status,
      this.reasonCancel,
      this.createDate,
      this.paymentTerm,
      this.price,
      this.brand,
      this.property,
      this.media,
      this.owner,
      // this.registrationNumber,
      // this.address,
      // this.area,
      this.brandRepresentativeCccd,
      this.contractTerms,
      this.brandRepresentativeAddress,
      this.brandRepresentativeBirthday,
      this.brandRepresentativeName,
      this.brandRepresentativePhoneNumber,
      this.leaseLength,
      this.lessor,
      this.lessorAddress,
      this.lessorBank,
      this.lessorBankAccountNumber,
      this.lessorBirthDate,
      this.lessorCccd,
      this.lessorCccdGrantAddress,
      this.lessorCccdGrantDate,
      // this.lessorName,
      // this.lessorPhoneNumber,
      this.payDay,
      // this.priceInText,
      // this.registrationNumber,
      this.registrationNumberGrantAddress,
      this.registrationNumberGrantDate,
      // this.renter,
      this.renterOfficeAddress,
      this.signAddress,
      this.signDate,
      this.brandRepresentativeCccdGrantAddress,
      this.brandRepresentativeCccdGrantDate,
      this.handoverDate});

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
