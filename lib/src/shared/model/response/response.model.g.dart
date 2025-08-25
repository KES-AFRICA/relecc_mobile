// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseModel<T>(
      success: json['success'] as bool?,
      error: json['error'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      accessToken: json['accessToken'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'accessToken': instance.accessToken,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'roles': instance.roles,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

ResponseModelWithList<T> _$ResponseModelWithListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseModelWithList<T>(
      success: json['success'] as bool?,
      error: json['error'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ResponseModelWithListToJson<T>(
  ResponseModelWithList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map(toJsonT).toList(),
    };
