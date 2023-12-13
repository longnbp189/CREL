import 'package:crel_mobile/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'brandId')
  final int? brandId;
  @JsonKey(name: 'brokerId')
  final int? brokerId;
  @JsonKey(name: 'propertyId')
  final int? propertyId;
  @JsonKey(name: 'onDateTime')
  final DateTime? onDateTime;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'description')
  final String? description;
  // @JsonKey(name: 'slot')
  // final int? slot;

  @JsonKey(name: 'createDateTime')
  final DateTime? createDateTime;

  @JsonKey(name: 'rejectMessage')
  final String? rejectMessage;
  @JsonKey(name: 'brand')
  final Brand? brand;
  @JsonKey(name: 'property')
  final Property? property;

  Appointment(
      {this.id,
      this.brandId,
      this.brokerId,
      this.onDateTime,
      this.description,
      // this.slot,
      this.status,
      this.propertyId,
      // this.brandFreeTime1,
      // this.brandFreeTime2,
      // this.brandFreeTime3,
      this.createDateTime,
      this.property,
      this.brand,
      this.rejectMessage});

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
