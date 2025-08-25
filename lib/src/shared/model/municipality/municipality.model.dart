import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'municipality.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 19)
class Municipality {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @HiveField(3)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Municipality({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Municipality.fromJson(Map<String, dynamic> json) => _$MunicipalityFromJson(json);
  Map<String, dynamic> toJson() => _$MunicipalityToJson(this);
}