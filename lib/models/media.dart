import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable(explicitToJson: true)
class Media {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'fileId')
  final String? fileId;
  @JsonKey(name: 'propertyId')
  final int? propertyId;
  @JsonKey(name: 'projectId')
  final int? projectId;
  @JsonKey(name: 'contractId')
  final int? contractId;
  @JsonKey(name: 'type')
  final int? type;

  Media(
      {this.id,
      this.link,
      this.fileId,
      this.propertyId,
      this.projectId,
      this.type,
      this.contractId});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
