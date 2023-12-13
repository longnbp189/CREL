import 'package:crel_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggest_property.g.dart';

@JsonSerializable(explicitToJson: true)
class SuggestProperty {
  @JsonKey(name: 'brandId')
  final int? brandId;
  @JsonKey(name: 'propertyId')
  final int? propertyId;
  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'property')
  final Property? property;
  @JsonKey(name: 'brand')
  final Brand? brand;

  SuggestProperty({
    this.brandId,
    this.propertyId,
    this.type,
    this.property,
    this.brand,
  });

  factory SuggestProperty.fromJson(Map<String, dynamic> json) =>
      _$SuggestPropertyFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$SuggestPropertyToJson(this);
}
