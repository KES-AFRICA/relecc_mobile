// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_type.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterventionType _$InterventionTypeFromJson(Map<String, dynamic> json) =>
    InterventionType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$InterventionTypeToJson(InterventionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
