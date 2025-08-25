// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MissionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionStateCopyWith<$Res> {
  factory $MissionStateCopyWith(
          MissionState value, $Res Function(MissionState) then) =
      _$MissionStateCopyWithImpl<$Res, MissionState>;
}

/// @nodoc
class _$MissionStateCopyWithImpl<$Res, $Val extends MissionState>
    implements $MissionStateCopyWith<$Res> {
  _$MissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MissionInitialImplCopyWith<$Res> {
  factory _$$MissionInitialImplCopyWith(_$MissionInitialImpl value,
          $Res Function(_$MissionInitialImpl) then) =
      __$$MissionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MissionInitialImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionInitialImpl>
    implements _$$MissionInitialImplCopyWith<$Res> {
  __$$MissionInitialImplCopyWithImpl(
      _$MissionInitialImpl _value, $Res Function(_$MissionInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MissionInitialImpl implements _MissionInitial {
  _$MissionInitialImpl();

  @override
  String toString() {
    return 'MissionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MissionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _MissionInitial implements MissionState {
  factory _MissionInitial() = _$MissionInitialImpl;
}

/// @nodoc
abstract class _$$MissionLoadingImplCopyWith<$Res> {
  factory _$$MissionLoadingImplCopyWith(_$MissionLoadingImpl value,
          $Res Function(_$MissionLoadingImpl) then) =
      __$$MissionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MissionLoadingImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionLoadingImpl>
    implements _$$MissionLoadingImplCopyWith<$Res> {
  __$$MissionLoadingImplCopyWithImpl(
      _$MissionLoadingImpl _value, $Res Function(_$MissionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MissionLoadingImpl implements _MissionLoading {
  _$MissionLoadingImpl();

  @override
  String toString() {
    return 'MissionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MissionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _MissionLoading implements MissionState {
  factory _MissionLoading() = _$MissionLoadingImpl;
}

/// @nodoc
abstract class _$$MissionSucessImplCopyWith<$Res> {
  factory _$$MissionSucessImplCopyWith(
          _$MissionSucessImpl value, $Res Function(_$MissionSucessImpl) then) =
      __$$MissionSucessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModelWithList<Mission> response});
}

/// @nodoc
class __$$MissionSucessImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionSucessImpl>
    implements _$$MissionSucessImplCopyWith<$Res> {
  __$$MissionSucessImplCopyWithImpl(
      _$MissionSucessImpl _value, $Res Function(_$MissionSucessImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSucessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModelWithList<Mission>,
    ));
  }
}

/// @nodoc

class _$MissionSucessImpl implements _MissionSucess {
  _$MissionSucessImpl({required this.response});

  @override
  final ResponseModelWithList<Mission> response;

  @override
  String toString() {
    return 'MissionState.success(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSucessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSucessImplCopyWith<_$MissionSucessImpl> get copyWith =>
      __$$MissionSucessImplCopyWithImpl<_$MissionSucessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return success(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return success?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _MissionSucess implements MissionState {
  factory _MissionSucess(
          {required final ResponseModelWithList<Mission> response}) =
      _$MissionSucessImpl;

  ResponseModelWithList<Mission> get response;

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionSucessImplCopyWith<_$MissionSucessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSucessEquipementImplCopyWith<$Res> {
  factory _$$MissionSucessEquipementImplCopyWith(
          _$MissionSucessEquipementImpl value,
          $Res Function(_$MissionSucessEquipementImpl) then) =
      __$$MissionSucessEquipementImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<EquipmentResponse> response});
}

/// @nodoc
class __$$MissionSucessEquipementImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionSucessEquipementImpl>
    implements _$$MissionSucessEquipementImplCopyWith<$Res> {
  __$$MissionSucessEquipementImplCopyWithImpl(
      _$MissionSucessEquipementImpl _value,
      $Res Function(_$MissionSucessEquipementImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSucessEquipementImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<EquipmentResponse>,
    ));
  }
}

/// @nodoc

class _$MissionSucessEquipementImpl implements _MissionSucessEquipement {
  _$MissionSucessEquipementImpl({required this.response});

  @override
  final ResponseModel<EquipmentResponse> response;

  @override
  String toString() {
    return 'MissionState.successEquipment(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSucessEquipementImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSucessEquipementImplCopyWith<_$MissionSucessEquipementImpl>
      get copyWith => __$$MissionSucessEquipementImplCopyWithImpl<
          _$MissionSucessEquipementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return successEquipment(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return successEquipment?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successEquipment != null) {
      return successEquipment(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successEquipment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successEquipment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successEquipment != null) {
      return successEquipment(this);
    }
    return orElse();
  }
}

abstract class _MissionSucessEquipement implements MissionState {
  factory _MissionSucessEquipement(
          {required final ResponseModel<EquipmentResponse> response}) =
      _$MissionSucessEquipementImpl;

  ResponseModel<EquipmentResponse> get response;

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionSucessEquipementImplCopyWith<_$MissionSucessEquipementImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSucessEquipementMaintenanceImplCopyWith<$Res> {
  factory _$$MissionSucessEquipementMaintenanceImplCopyWith(
          _$MissionSucessEquipementMaintenanceImpl value,
          $Res Function(_$MissionSucessEquipementMaintenanceImpl) then) =
      __$$MissionSucessEquipementMaintenanceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<EquipmentMaintenanceResponse> response});
}

/// @nodoc
class __$$MissionSucessEquipementMaintenanceImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res,
        _$MissionSucessEquipementMaintenanceImpl>
    implements _$$MissionSucessEquipementMaintenanceImplCopyWith<$Res> {
  __$$MissionSucessEquipementMaintenanceImplCopyWithImpl(
      _$MissionSucessEquipementMaintenanceImpl _value,
      $Res Function(_$MissionSucessEquipementMaintenanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSucessEquipementMaintenanceImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<EquipmentMaintenanceResponse>,
    ));
  }
}

/// @nodoc

class _$MissionSucessEquipementMaintenanceImpl
    implements _MissionSucessEquipementMaintenance {
  _$MissionSucessEquipementMaintenanceImpl({required this.response});

  @override
  final ResponseModel<EquipmentMaintenanceResponse> response;

  @override
  String toString() {
    return 'MissionState.successEquipmentMaintenance(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSucessEquipementMaintenanceImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSucessEquipementMaintenanceImplCopyWith<
          _$MissionSucessEquipementMaintenanceImpl>
      get copyWith => __$$MissionSucessEquipementMaintenanceImplCopyWithImpl<
          _$MissionSucessEquipementMaintenanceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return successEquipmentMaintenance(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return successEquipmentMaintenance?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successEquipmentMaintenance != null) {
      return successEquipmentMaintenance(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successEquipmentMaintenance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successEquipmentMaintenance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successEquipmentMaintenance != null) {
      return successEquipmentMaintenance(this);
    }
    return orElse();
  }
}

abstract class _MissionSucessEquipementMaintenance implements MissionState {
  factory _MissionSucessEquipementMaintenance(
      {required final ResponseModel<EquipmentMaintenanceResponse>
          response}) = _$MissionSucessEquipementMaintenanceImpl;

  ResponseModel<EquipmentMaintenanceResponse> get response;

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionSucessEquipementMaintenanceImplCopyWith<
          _$MissionSucessEquipementMaintenanceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionFailedImplCopyWith<$Res> {
  factory _$$MissionFailedImplCopyWith(
          _$MissionFailedImpl value, $Res Function(_$MissionFailedImpl) then) =
      __$$MissionFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$MissionFailedImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionFailedImpl>
    implements _$$MissionFailedImplCopyWith<$Res> {
  __$$MissionFailedImplCopyWithImpl(
      _$MissionFailedImpl _value, $Res Function(_$MissionFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MissionFailedImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MissionFailedImpl implements _MissionFailed {
  _$MissionFailedImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'MissionState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionFailedImplCopyWith<_$MissionFailedImpl> get copyWith =>
      __$$MissionFailedImplCopyWithImpl<_$MissionFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModelWithList<Mission> response) success,
    required TResult Function(ResponseModel<EquipmentResponse> response)
        successEquipment,
    required TResult Function(
            ResponseModel<EquipmentMaintenanceResponse> response)
        successEquipmentMaintenance,
    required TResult Function(String error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModelWithList<Mission> response)? success,
    TResult? Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult? Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult? Function(String error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModelWithList<Mission> response)? success,
    TResult Function(ResponseModel<EquipmentResponse> response)?
        successEquipment,
    TResult Function(ResponseModel<EquipmentMaintenanceResponse> response)?
        successEquipmentMaintenance,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MissionInitial value) initial,
    required TResult Function(_MissionLoading value) loading,
    required TResult Function(_MissionSucess value) success,
    required TResult Function(_MissionSucessEquipement value) successEquipment,
    required TResult Function(_MissionSucessEquipementMaintenance value)
        successEquipmentMaintenance,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MissionInitial value)? initial,
    TResult? Function(_MissionLoading value)? loading,
    TResult? Function(_MissionSucess value)? success,
    TResult? Function(_MissionSucessEquipement value)? successEquipment,
    TResult? Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MissionInitial value)? initial,
    TResult Function(_MissionLoading value)? loading,
    TResult Function(_MissionSucess value)? success,
    TResult Function(_MissionSucessEquipement value)? successEquipment,
    TResult Function(_MissionSucessEquipementMaintenance value)?
        successEquipmentMaintenance,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _MissionFailed implements MissionState {
  factory _MissionFailed({required final String error}) = _$MissionFailedImpl;

  String get error;

  /// Create a copy of MissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionFailedImplCopyWith<_$MissionFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
