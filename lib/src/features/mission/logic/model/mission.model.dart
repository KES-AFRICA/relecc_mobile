import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/intervention_type/intervention_type.model.dart';
import 'package:sopaki_app/src/shared/model/street/street.model.dart';

part 'mission.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 16)
class MissionResponse extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  @JsonKey(name: 'user_id')
  final int? userId;

  @HiveField(4)
  @JsonKey(name: 'intervention_type_id')
  final int? interventionTypeId;

  @HiveField(5)
  @JsonKey(name: 'network_type')
  final String? networkType;

  @HiveField(6)
  final String? status;

  @HiveField(7)
  @JsonKey(name: 'started_at')
  final String? startedAt;

  @HiveField(8)
  @JsonKey(name: 'finished_at')
  final String? finishedAt;

  @HiveField(9)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @HiveField(10)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @HiveField(11)
  final List<Street>? streets;

  @HiveField(12)
  @JsonKey(name: 'intervention_type')
  final InterventionType? interventionType;

  MissionResponse({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.interventionTypeId,
    this.networkType,
    this.status,
    this.startedAt,
    this.finishedAt,
    this.createdAt,
    this.updatedAt,
    this.streets,
    this.interventionType,
  });

  factory MissionResponse.fromJson(Map<String, dynamic> json) => _$MissionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MissionResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 17)
class Mission extends HiveObject {
  @HiveField(0)
  final MissionResponse? mission;

  Mission({this.mission});

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
  Map<String, dynamic> toJson() => _$MissionToJson(this);
}
// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:sopaki_app/src/shared/model/intervention_type/intervention_type.model.dart';

// part 'mission.model.g.dart';

// @JsonSerializable()
// @HiveType(typeId: 16)
// class MissionResponse    extends HiveObject {
//   @HiveField(0)
//   @JsonKey(name: 'title')
//   final String? title;
//   @HiveField(1)
//   final String? description;
//   @HiveField(2)
//   @JsonKey(name: 'intervention_type')
//   final InterventionType? interventionType;
//   @HiveField(3)
//   final int? id;
//   @HiveField(4)
//   @JsonKey(name: 'user_id')
//   final int? userId;
//   @HiveField(5)
//   @JsonKey(name: 'intervention_type_id')
//   final int? interventionTypeId;
//   @HiveField(6)
//   @JsonKey(name: 'network_type')
//   final String? networkType;
//   @HiveField(7)
//   final String? status;
//   @JsonKey(name: 'started_at')
//   final String? startedAt;
//   @HiveField(8)
//   @JsonKey(name: 'finished_at')
//   final String? finishedAt;

//   MissionResponse(
//       {this.title,
//       this.description,
//       this.interventionType,
//       this.id,
//       this.userId,
//       this.interventionTypeId,
//       this.networkType,
//       this.status,
//       this.startedAt,
//       this.finishedAt});

//   factory MissionResponse.fromJson(Map<String, dynamic> json) => _$MissionResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$MissionResponseToJson(this);
// }

// @JsonSerializable()
// @HiveType(typeId: 17)
// class Mission   extends HiveObject {
//   @HiveField(0)
//   @JsonKey(name: 'mission')
//   final MissionResponse? mission;

//   Mission({this.mission});

//   factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);

//   Map<String, dynamic> toJson() => _$MissionToJson(this);
// }
