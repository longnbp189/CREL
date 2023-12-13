import 'package:crel_mobile/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'firebaseUid')
  final String? firebaseUid;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'rejectMessage')
  final String? rejectMessage;
  @JsonKey(name: 'avatarFileId')
  final String? avatarFileId;
  @JsonKey(name: 'avatarLink')
  final String? avatarLink;
  @JsonKey(name: 'industryId')
  final int? industryId;

  @JsonKey(name: 'registrationNumber')
  final String? registrationNumber;
  @JsonKey(name: 'stores')
  final List<Store>? stores;

  Brand(
      {this.id,
      this.name,
      this.industryId,
      this.phoneNumber,
      this.email,
      this.avatarLink,
      this.description,
      this.status,
      this.avatarFileId,
      this.firebaseUid,
      this.registrationNumber,
      this.rejectMessage,
      this.stores,
      this.userName});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
