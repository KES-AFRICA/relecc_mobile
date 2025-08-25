import 'package:json_annotation/json_annotation.dart';

part 'company.model.g.dart';

@JsonSerializable()
class Company {
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'logo')
  final String? logo;


  Company({required this.id, required this.name, this.logo});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}