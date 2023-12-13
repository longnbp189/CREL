// import 'package:json_annotation/json_annotation.dart';

// part 'notification.g.dart';

// @JsonSerializable(explicitToJson: true)
// class Notification {
//   @JsonKey(name: 'id')
//   final int? id;
//   @JsonKey(name: 'description')
//   final String? description;
//   @JsonKey(name: 'name')
//   final String? type;
//   @JsonKey(name: 'OnDateTime')
//   final int? onDateTime;

//   Notification({
//     this.id,
//     this.description,
//     this.name,
//     this.status,
//   });

//   factory Notification.fromJson(Map<String, dynamic> json) =>
//       _$NotificationFromJson(json);

//   /// to JSON. The implementation simply calls the private, generated
//   /// helper method `_$EventToJson`.
//   Map<String, dynamic> toJson() => _$NotificationToJson(this);
// }
