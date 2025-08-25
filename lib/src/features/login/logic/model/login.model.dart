import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/user/user.model.dart';

part 'login.model.g.dart';

@JsonSerializable()
class Login {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'token')
  final String token;
  final User? user;

  LoginResponse(
      {required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
