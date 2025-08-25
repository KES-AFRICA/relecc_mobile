import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/user/user.model.dart';

part 'user_profil.model.g.dart';

@JsonSerializable()
class UserProfil {
  final User? user;


  UserProfil({this.user});

  factory UserProfil.fromJson(Map<String, dynamic> json) => _$UserProfilFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfilToJson(this);
}