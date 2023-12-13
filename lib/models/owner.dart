import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable(explicitToJson: true)
class Owner {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final bool? gender;
  @JsonKey(name: 'status')
  final int? status;

  Owner({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.gender,
    this.status,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
