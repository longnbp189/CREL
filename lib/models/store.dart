import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'brandId')
  final int? brandId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'address')
  final String? address;

  Store({
    this.id,
    this.brandId,
    this.name,
    this.address,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
