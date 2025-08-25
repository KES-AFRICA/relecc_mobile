import 'package:json_annotation/json_annotation.dart';

part 'intervention_type.model.g.dart';

@JsonSerializable()
class InterventionType {
  final int id;
  @JsonKey(name: 'name')
  final String name;

  InterventionType({required this.id, required this.name});

  factory InterventionType.fromJson(Map<String, dynamic> json) => _$InterventionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$InterventionTypeToJson(this);
}
