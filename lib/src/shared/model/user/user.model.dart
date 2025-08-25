import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/compagny/company.model.dart';
import 'package:sopaki_app/src/shared/model/roles/role.model.dart';

part 'user.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  @JsonKey(name: 'company_id')
  final int companyId;
  @HiveField(2)
  @JsonKey(name: 'name')
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  @JsonKey(name: 'phone')
  final String? phone;
  @HiveField(5)
  @JsonKey(name: 'sex')
  @HiveField(6)
  final String? sex;
  @HiveField(7)
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;
  @HiveField(8)
  @JsonKey(name: 'is_active')
  final int? isActive;
  @HiveField(9)
  final List<Role>? roles;
  @HiveField(10)
  final Company? company;

  User(
      {required this.id,
      required this.companyId,
      required this.name,
      required this.email,
      this.phone,
      this.sex,
      this.emailVerifiedAt,
      this.isActive,
      this.company,
      this.roles});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
