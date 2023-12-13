import 'package:crel_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'districtId')
  final int? districtId;
  @JsonKey(name: 'handoverYear')
  final DateTime? handoverYear;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'media')
  final List<Media>? media;

  Project(
      {this.id,
      this.status,
      this.description,
      this.name,
      this.districtId,
      this.handoverYear,
      this.company,
      this.media});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
