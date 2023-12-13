import 'package:crel_mobile/models/street_segment.dart';
import 'package:crel_mobile/models/ward.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'placeId')
  final String? placeId;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'wardId')
  final int? wardId;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'streetSegment')
  final StreetSegment? streetSegment;
  @JsonKey(name: 'ward')
  final Ward? ward;

  Location(
      {this.id,
      this.status,
      this.placeId,
      this.address,
      this.wardId,
      this.latitude,
      this.longitude,
      this.streetSegment,
      this.ward});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
