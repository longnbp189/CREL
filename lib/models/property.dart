import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable(explicitToJson: true)
class Property {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'locationId')
  final int? locationId;
  @JsonKey(name: 'brokerId')
  final int? brokerId;
  @JsonKey(name: 'createDate')
  final DateTime? createDate;
  @JsonKey(name: 'lastUpdateDate')
  final DateTime? lastUpdateDate;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'rejectReason')
  final String? rejectReason;

  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'projectId')
  final int? projectId;
  @JsonKey(name: 'direction')
  final int? direction;
  @JsonKey(name: 'floor')
  final String? floor;
  @JsonKey(name: 'floorArea')
  final double? floorArea;
  @JsonKey(name: 'frontage')
  final double? frontage;
  @JsonKey(name: 'area')
  final double? area;

  @JsonKey(name: 'certificates')
  final int? certificates;
  @JsonKey(name: 'vertical')
  final double? vertical;
  @JsonKey(name: 'horizontal')
  final double? horizontal;
  @JsonKey(name: 'roadWidth')
  final double? roadWidth;
  @JsonKey(name: 'rentalCondition')
  final String? rentalCondition;
  @JsonKey(name: 'rentalTerm')
  final String? rentalTerm;
  @JsonKey(name: 'depositTerm')
  final String? depositTerm;
  @JsonKey(name: 'paymentTerm')
  final String? paymentTerm;
  @JsonKey(name: 'media')
  final List<Media>? media;
  @JsonKey(name: 'owners')
  final List<Owner>? owners;
  @JsonKey(name: 'numberOfFrontage')
  final int? numberOfFrontage;
  @JsonKey(name: 'location')
  final Location? location;
  // @JsonKey(name: 'contacts')
  // final List<Contact>? contacts;
  @JsonKey(name: 'project')
  final Project? project;

  Property(
      {this.id,
      this.locationId,
      this.brokerId,
      this.createDate,
      this.lastUpdateDate,
      this.price,
      this.status,
      this.description,
      this.rejectReason,
      this.type,
      this.name,
      this.projectId,
      this.direction,
      this.floor,
      this.floorArea,
      this.frontage,
      this.certificates,
      this.vertical,
      this.horizontal,
      this.roadWidth,
      this.rentalCondition,
      this.rentalTerm,
      this.depositTerm,
      this.paymentTerm,
      this.media,
      this.owners,
      this.location,
      this.area,
      this.project,
      this.numberOfFrontage});

  // QuillController getQuillDescription(String description) {
  //   try {
  //     return QuillController(
  //         document: Document.fromJson(jsonDecode(description)),
  //         selection: const TextSelection.collapsed(offset: 0));
  //   } catch (e) {}
  //   return QuillController.basic();
  // }

  // String quillDeltaToHtml(Delta delta) {
  //   // final convertedValue = jsonEncode(delta.toJson());
  //   // const deltaa =
  //   // r'[{"insert":"Hello "},{"insert":"Markdown","attributes":{"bold":true}},{"insert":"\n"}]';
  //   // String deltaa = convertedValue.replaceAll("\n", "\\\n");
  //   // print(deltaa);
  //   // print(deltaa);
  //   // const delta =
  //   // r'[{"insert":"Hello "},{"insert":"Markdown","attributes":{"bold":true}},{"insert":"\n"}]';
  //   // final markdown = delta_markdown.deltaToMarkdown(convertedValue);

  //   final html = DeltaToHTML.encodeJson(delta.toJson());
  //   print(html);
  //   return html;
  // }

  // QuillController htmlToQuillController(String html) {
  //   final markdown = html2md.convert(html);
  //   print(markdown);
  //   final delta = delta_markdown.markdownToDelta(markdown);
  //   print(delta);

  //   return QuillController(
  //       document: Document.fromJson(jsonDecode(delta)),
  //       selection: const TextSelection.collapsed(offset: 0));
  // }

  //  String htmlToQuillController(String html) {
  //   final markdown = html2md.convert(html);
  //   final delta = delta_markdown.markdownToDelta(markdown);

  //   return delta;
  // }

  // String? getQuillDescription() {
  //   String? descriptiontmp = description;
  //   try {
  //     descriptiontmp = QuillController(
  //             document: Document.fromJson(jsonDecode(description!)),
  //             selection: const TextSelection.collapsed(offset: 0))
  //         .document
  //         .toPlainText();
  //   } catch (e) {}
  //   return descriptiontmp;
  // }

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
