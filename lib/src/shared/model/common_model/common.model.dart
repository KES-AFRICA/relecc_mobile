import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 8)
class Common extends HiveObject {
  @HiveField(0)
  final int id;
  @JsonKey(name: 'municipality_id')
  @HiveField(1)
  final int? municipalityId;
  @HiveField(2)
  @JsonKey(name: 'name')
  final String name;
  @HiveField(3)
  @JsonKey(name: 'description')
  final String? description;
  @HiveField(4)
  @JsonKey(name: 'hex')
  final String? hex;

  Common({this.municipalityId, this.hex, required this.id, required this.name, this.description});

  factory Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);

  Map<String, dynamic> toJson() => _$CommonToJson(this);
}
