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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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

  @JsonKey(ignore: true)
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
  @JsonKey(ignore: true)
  _$$MissionSucessEquipementMaintenanceImplCopyWith<
          _$MissionSucessEquipementMaintenanceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSuccessNetworkAnalysisImplCopyWith<$Res> {
  factory _$$MissionSuccessNetworkAnalysisImplCopyWith(
          _$MissionSuccessNetworkAnalysisImpl value,
          $Res Function(_$MissionSuccessNetworkAnalysisImpl) then) =
      __$$MissionSuccessNetworkAnalysisImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<NetworkAnalysisResponse> response});
}

/// @nodoc
class __$$MissionSuccessNetworkAnalysisImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res,
        _$MissionSuccessNetworkAnalysisImpl>
    implements _$$MissionSuccessNetworkAnalysisImplCopyWith<$Res> {
  __$$MissionSuccessNetworkAnalysisImplCopyWithImpl(
      _$MissionSuccessNetworkAnalysisImpl _value,
      $Res Function(_$MissionSuccessNetworkAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSuccessNetworkAnalysisImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<NetworkAnalysisResponse>,
    ));
  }
}

/// @nodoc

class _$MissionSuccessNetworkAnalysisImpl
    implements _MissionSuccessNetworkAnalysis {
  _$MissionSuccessNetworkAnalysisImpl({required this.response});

  @override
  final ResponseModel<NetworkAnalysisResponse> response;

  @override
  String toString() {
    return 'MissionState.successNetworkAnalysis(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSuccessNetworkAnalysisImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSuccessNetworkAnalysisImplCopyWith<
          _$MissionSuccessNetworkAnalysisImpl>
      get copyWith => __$$MissionSuccessNetworkAnalysisImplCopyWithImpl<
          _$MissionSuccessNetworkAnalysisImpl>(this, _$identity);

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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
    required TResult Function(String error) failure,
  }) {
    return successNetworkAnalysis(response);
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult? Function(String error)? failure,
  }) {
    return successNetworkAnalysis?.call(response);
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkAnalysis != null) {
      return successNetworkAnalysis(response);
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successNetworkAnalysis(this);
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successNetworkAnalysis?.call(this);
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkAnalysis != null) {
      return successNetworkAnalysis(this);
    }
    return orElse();
  }
}

abstract class _MissionSuccessNetworkAnalysis implements MissionState {
  factory _MissionSuccessNetworkAnalysis(
          {required final ResponseModel<NetworkAnalysisResponse> response}) =
      _$MissionSuccessNetworkAnalysisImpl;

  ResponseModel<NetworkAnalysisResponse> get response;
  @JsonKey(ignore: true)
  _$$MissionSuccessNetworkAnalysisImplCopyWith<
          _$MissionSuccessNetworkAnalysisImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSuccessNetworkFilterOptionsImplCopyWith<$Res> {
  factory _$$MissionSuccessNetworkFilterOptionsImplCopyWith(
          _$MissionSuccessNetworkFilterOptionsImpl value,
          $Res Function(_$MissionSuccessNetworkFilterOptionsImpl) then) =
      __$$MissionSuccessNetworkFilterOptionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<NetworkFilterOptionsResponse> response});
}

/// @nodoc
class __$$MissionSuccessNetworkFilterOptionsImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res,
        _$MissionSuccessNetworkFilterOptionsImpl>
    implements _$$MissionSuccessNetworkFilterOptionsImplCopyWith<$Res> {
  __$$MissionSuccessNetworkFilterOptionsImplCopyWithImpl(
      _$MissionSuccessNetworkFilterOptionsImpl _value,
      $Res Function(_$MissionSuccessNetworkFilterOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSuccessNetworkFilterOptionsImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<NetworkFilterOptionsResponse>,
    ));
  }
}

/// @nodoc

class _$MissionSuccessNetworkFilterOptionsImpl
    implements _MissionSuccessNetworkFilterOptions {
  _$MissionSuccessNetworkFilterOptionsImpl({required this.response});

  @override
  final ResponseModel<NetworkFilterOptionsResponse> response;

  @override
  String toString() {
    return 'MissionState.successNetworkFilterOptions(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSuccessNetworkFilterOptionsImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSuccessNetworkFilterOptionsImplCopyWith<
          _$MissionSuccessNetworkFilterOptionsImpl>
      get copyWith => __$$MissionSuccessNetworkFilterOptionsImplCopyWithImpl<
          _$MissionSuccessNetworkFilterOptionsImpl>(this, _$identity);

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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
    required TResult Function(String error) failure,
  }) {
    return successNetworkFilterOptions(response);
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult? Function(String error)? failure,
  }) {
    return successNetworkFilterOptions?.call(response);
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkFilterOptions != null) {
      return successNetworkFilterOptions(response);
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successNetworkFilterOptions(this);
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successNetworkFilterOptions?.call(this);
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkFilterOptions != null) {
      return successNetworkFilterOptions(this);
    }
    return orElse();
  }
}

abstract class _MissionSuccessNetworkFilterOptions implements MissionState {
  factory _MissionSuccessNetworkFilterOptions(
      {required final ResponseModel<NetworkFilterOptionsResponse>
          response}) = _$MissionSuccessNetworkFilterOptionsImpl;

  ResponseModel<NetworkFilterOptionsResponse> get response;
  @JsonKey(ignore: true)
  _$$MissionSuccessNetworkFilterOptionsImplCopyWith<
          _$MissionSuccessNetworkFilterOptionsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSuccessNetworkDetailsImplCopyWith<$Res> {
  factory _$$MissionSuccessNetworkDetailsImplCopyWith(
          _$MissionSuccessNetworkDetailsImpl value,
          $Res Function(_$MissionSuccessNetworkDetailsImpl) then) =
      __$$MissionSuccessNetworkDetailsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<Map<String, dynamic>> response});
}

/// @nodoc
class __$$MissionSuccessNetworkDetailsImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionSuccessNetworkDetailsImpl>
    implements _$$MissionSuccessNetworkDetailsImplCopyWith<$Res> {
  __$$MissionSuccessNetworkDetailsImplCopyWithImpl(
      _$MissionSuccessNetworkDetailsImpl _value,
      $Res Function(_$MissionSuccessNetworkDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSuccessNetworkDetailsImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$MissionSuccessNetworkDetailsImpl
    implements _MissionSuccessNetworkDetails {
  _$MissionSuccessNetworkDetailsImpl({required this.response});

  @override
  final ResponseModel<Map<String, dynamic>> response;

  @override
  String toString() {
    return 'MissionState.successNetworkDetails(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSuccessNetworkDetailsImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSuccessNetworkDetailsImplCopyWith<
          _$MissionSuccessNetworkDetailsImpl>
      get copyWith => __$$MissionSuccessNetworkDetailsImplCopyWithImpl<
          _$MissionSuccessNetworkDetailsImpl>(this, _$identity);

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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
    required TResult Function(String error) failure,
  }) {
    return successNetworkDetails(response);
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult? Function(String error)? failure,
  }) {
    return successNetworkDetails?.call(response);
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkDetails != null) {
      return successNetworkDetails(response);
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successNetworkDetails(this);
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successNetworkDetails?.call(this);
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkDetails != null) {
      return successNetworkDetails(this);
    }
    return orElse();
  }
}

abstract class _MissionSuccessNetworkDetails implements MissionState {
  factory _MissionSuccessNetworkDetails(
          {required final ResponseModel<Map<String, dynamic>> response}) =
      _$MissionSuccessNetworkDetailsImpl;

  ResponseModel<Map<String, dynamic>> get response;
  @JsonKey(ignore: true)
  _$$MissionSuccessNetworkDetailsImplCopyWith<
          _$MissionSuccessNetworkDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSuccessNetworkQuickStatsImplCopyWith<$Res> {
  factory _$$MissionSuccessNetworkQuickStatsImplCopyWith(
          _$MissionSuccessNetworkQuickStatsImpl value,
          $Res Function(_$MissionSuccessNetworkQuickStatsImpl) then) =
      __$$MissionSuccessNetworkQuickStatsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<Map<String, dynamic>> response});
}

/// @nodoc
class __$$MissionSuccessNetworkQuickStatsImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res,
        _$MissionSuccessNetworkQuickStatsImpl>
    implements _$$MissionSuccessNetworkQuickStatsImplCopyWith<$Res> {
  __$$MissionSuccessNetworkQuickStatsImplCopyWithImpl(
      _$MissionSuccessNetworkQuickStatsImpl _value,
      $Res Function(_$MissionSuccessNetworkQuickStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSuccessNetworkQuickStatsImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$MissionSuccessNetworkQuickStatsImpl
    implements _MissionSuccessNetworkQuickStats {
  _$MissionSuccessNetworkQuickStatsImpl({required this.response});

  @override
  final ResponseModel<Map<String, dynamic>> response;

  @override
  String toString() {
    return 'MissionState.successNetworkQuickStats(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSuccessNetworkQuickStatsImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSuccessNetworkQuickStatsImplCopyWith<
          _$MissionSuccessNetworkQuickStatsImpl>
      get copyWith => __$$MissionSuccessNetworkQuickStatsImplCopyWithImpl<
          _$MissionSuccessNetworkQuickStatsImpl>(this, _$identity);

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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
    required TResult Function(String error) failure,
  }) {
    return successNetworkQuickStats(response);
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult? Function(String error)? failure,
  }) {
    return successNetworkQuickStats?.call(response);
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkQuickStats != null) {
      return successNetworkQuickStats(response);
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successNetworkQuickStats(this);
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successNetworkQuickStats?.call(this);
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkQuickStats != null) {
      return successNetworkQuickStats(this);
    }
    return orElse();
  }
}

abstract class _MissionSuccessNetworkQuickStats implements MissionState {
  factory _MissionSuccessNetworkQuickStats(
          {required final ResponseModel<Map<String, dynamic>> response}) =
      _$MissionSuccessNetworkQuickStatsImpl;

  ResponseModel<Map<String, dynamic>> get response;
  @JsonKey(ignore: true)
  _$$MissionSuccessNetworkQuickStatsImplCopyWith<
          _$MissionSuccessNetworkQuickStatsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissionSuccessNetworkExportImplCopyWith<$Res> {
  factory _$$MissionSuccessNetworkExportImplCopyWith(
          _$MissionSuccessNetworkExportImpl value,
          $Res Function(_$MissionSuccessNetworkExportImpl) then) =
      __$$MissionSuccessNetworkExportImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<Map<String, dynamic>> response});
}

/// @nodoc
class __$$MissionSuccessNetworkExportImplCopyWithImpl<$Res>
    extends _$MissionStateCopyWithImpl<$Res, _$MissionSuccessNetworkExportImpl>
    implements _$$MissionSuccessNetworkExportImplCopyWith<$Res> {
  __$$MissionSuccessNetworkExportImplCopyWithImpl(
      _$MissionSuccessNetworkExportImpl _value,
      $Res Function(_$MissionSuccessNetworkExportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MissionSuccessNetworkExportImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$MissionSuccessNetworkExportImpl
    implements _MissionSuccessNetworkExport {
  _$MissionSuccessNetworkExportImpl({required this.response});

  @override
  final ResponseModel<Map<String, dynamic>> response;

  @override
  String toString() {
    return 'MissionState.successNetworkExport(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionSuccessNetworkExportImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionSuccessNetworkExportImplCopyWith<_$MissionSuccessNetworkExportImpl>
      get copyWith => __$$MissionSuccessNetworkExportImplCopyWithImpl<
          _$MissionSuccessNetworkExportImpl>(this, _$identity);

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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
    required TResult Function(String error) failure,
  }) {
    return successNetworkExport(response);
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult? Function(String error)? failure,
  }) {
    return successNetworkExport?.call(response);
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkExport != null) {
      return successNetworkExport(response);
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
    required TResult Function(_MissionFailed value) failure,
  }) {
    return successNetworkExport(this);
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult? Function(_MissionFailed value)? failure,
  }) {
    return successNetworkExport?.call(this);
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
    TResult Function(_MissionFailed value)? failure,
    required TResult orElse(),
  }) {
    if (successNetworkExport != null) {
      return successNetworkExport(this);
    }
    return orElse();
  }
}

abstract class _MissionSuccessNetworkExport implements MissionState {
  factory _MissionSuccessNetworkExport(
          {required final ResponseModel<Map<String, dynamic>> response}) =
      _$MissionSuccessNetworkExportImpl;

  ResponseModel<Map<String, dynamic>> get response;
  @JsonKey(ignore: true)
  _$$MissionSuccessNetworkExportImplCopyWith<_$MissionSuccessNetworkExportImpl>
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

  @JsonKey(ignore: true)
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
    required TResult Function(ResponseModel<NetworkAnalysisResponse> response)
        successNetworkAnalysis,
    required TResult Function(
            ResponseModel<NetworkFilterOptionsResponse> response)
        successNetworkFilterOptions,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkDetails,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkQuickStats,
    required TResult Function(ResponseModel<Map<String, dynamic>> response)
        successNetworkExport,
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
    TResult? Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult? Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult? Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    TResult Function(ResponseModel<NetworkAnalysisResponse> response)?
        successNetworkAnalysis,
    TResult Function(ResponseModel<NetworkFilterOptionsResponse> response)?
        successNetworkFilterOptions,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkDetails,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkQuickStats,
    TResult Function(ResponseModel<Map<String, dynamic>> response)?
        successNetworkExport,
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
    required TResult Function(_MissionSuccessNetworkAnalysis value)
        successNetworkAnalysis,
    required TResult Function(_MissionSuccessNetworkFilterOptions value)
        successNetworkFilterOptions,
    required TResult Function(_MissionSuccessNetworkDetails value)
        successNetworkDetails,
    required TResult Function(_MissionSuccessNetworkQuickStats value)
        successNetworkQuickStats,
    required TResult Function(_MissionSuccessNetworkExport value)
        successNetworkExport,
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
    TResult? Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult? Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult? Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult? Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult? Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
    TResult Function(_MissionSuccessNetworkAnalysis value)?
        successNetworkAnalysis,
    TResult Function(_MissionSuccessNetworkFilterOptions value)?
        successNetworkFilterOptions,
    TResult Function(_MissionSuccessNetworkDetails value)?
        successNetworkDetails,
    TResult Function(_MissionSuccessNetworkQuickStats value)?
        successNetworkQuickStats,
    TResult Function(_MissionSuccessNetworkExport value)? successNetworkExport,
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
  @JsonKey(ignore: true)
  _$$MissionFailedImplCopyWith<_$MissionFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
