// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profil.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfil _$UserProfilFromJson(Map<String, dynamic> json) => UserProfil(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfilToJson(UserProfil instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
