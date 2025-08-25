import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'neighborhood.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 20)
class Neighborhood {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;

  @HiveField(3)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @HiveField(4)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Neighborhood({
    this.id,
    this.name,
    this.municipalityId,
    this.createdAt,
    this.updatedAt,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) => _$NeighborhoodFromJson(json);
  Map<String, dynamic> toJson() => _$NeighborhoodToJson(this);
}