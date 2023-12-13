import 'package:crel_mobile/models/team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'broker.g.dart';

@JsonSerializable(explicitToJson: true)
class Broker {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'birthday')
  final DateTime? birthday;
  @JsonKey(name: 'gender')
  final bool? gender;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'teamId')
  final int? teamId;
  @JsonKey(name: 'avatarFileId')
  final String? avatarFileId;
  @JsonKey(name: 'avatarLink')
  final String? avatarLink;
  @JsonKey(name: 'team')
  final Team? team;

  Broker(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.birthday,
      this.gender,
      this.status,
      this.teamId,
      this.avatarFileId,
      this.avatarLink,
      this.team,
      this.userName});

  factory Broker.fromJson(Map<String, dynamic> json) => _$BrokerFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$BrokerToJson(this);
}
