import 'package:json_annotation/json_annotation.dart';

part 'contract_term.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractTerm {
  @JsonKey(name: 'index')
  final int? index;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'contractTerms')
  final List<ContractTerm>? contractTerms;

  ContractTerm({this.index, this.title, this.content, this.contractTerms});

  factory ContractTerm.fromJson(Map<String, dynamic> json) =>
      _$ContractTermFromJson(json);

  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ContractTermToJson(this);
}
