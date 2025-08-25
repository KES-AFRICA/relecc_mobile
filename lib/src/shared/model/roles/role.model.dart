import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Role extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'guard_name')
  final String guardName;

  Role({required this.id, required this.name, required this.guardName});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
