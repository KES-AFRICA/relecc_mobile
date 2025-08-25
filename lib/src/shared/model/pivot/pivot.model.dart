import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pivot.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 21)
class Pivot {
  @HiveField(0)
  @JsonKey(name: 'mission_id')
  final int? missionId;

  @HiveField(1)
  @JsonKey(name: 'street_id')
  final int? streetId;

  Pivot({
    this.missionId,
    this.streetId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);
  Map<String, dynamic> toJson() => _$PivotToJson(this);
}