import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/municipality/municipality.model.dart';
import 'package:sopaki_app/src/shared/model/neighborhood/neighborhood.model.dart';
import 'package:sopaki_app/src/shared/model/pivot/pivot.model.dart';

part 'street.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 18)
class Street {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;

  @HiveField(2)
  @JsonKey(name: 'neighborhood_id')
  final int? neighborhoodId;

  @HiveField(3)
  final String? name;

  @HiveField(4)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @HiveField(5)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @HiveField(6)
  final Municipality? municipality;

  @HiveField(7)
  final Neighborhood? neighborhood;

  @HiveField(8)
  final Pivot? pivot;

  Street({
    this.id,
    this.municipalityId,
    this.neighborhoodId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.municipality,
    this.neighborhood,
    this.pivot,
  });

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);
  Map<String, dynamic> toJson() => _$StreetToJson(this);
}