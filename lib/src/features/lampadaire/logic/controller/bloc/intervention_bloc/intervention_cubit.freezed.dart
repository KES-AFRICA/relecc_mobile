// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InterventionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionStateCopyWith<$Res> {
  factory $InterventionStateCopyWith(
          InterventionState value, $Res Function(InterventionState) then) =
      _$InterventionStateCopyWithImpl<$Res, InterventionState>;
}

/// @nodoc
class _$InterventionStateCopyWithImpl<$Res, $Val extends InterventionState>
    implements $InterventionStateCopyWith<$Res> {
  _$InterventionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InterventionStateInitialImplCopyWith<$Res> {
  factory _$$InterventionStateInitialImplCopyWith(
          _$InterventionStateInitialImpl value,
          $Res Function(_$InterventionStateInitialImpl) then) =
      __$$InterventionStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InterventionStateInitialImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res,
        _$InterventionStateInitialImpl>
    implements _$$InterventionStateInitialImplCopyWith<$Res> {
  __$$InterventionStateInitialImplCopyWithImpl(
      _$InterventionStateInitialImpl _value,
      $Res Function(_$InterventionStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InterventionStateInitialImpl implements _InterventionStateInitial {
  _$InterventionStateInitialImpl();

  @override
  String toString() {
    return 'InterventionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
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
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InterventionStateInitial implements InterventionState {
  factory _InterventionStateInitial() = _$InterventionStateInitialImpl;
}

/// @nodoc
abstract class _$$InterventionStateLoadingImplCopyWith<$Res> {
  factory _$$InterventionStateLoadingImplCopyWith(
          _$InterventionStateLoadingImpl value,
          $Res Function(_$InterventionStateLoadingImpl) then) =
      __$$InterventionStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InterventionStateLoadingImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res,
        _$InterventionStateLoadingImpl>
    implements _$$InterventionStateLoadingImplCopyWith<$Res> {
  __$$InterventionStateLoadingImplCopyWithImpl(
      _$InterventionStateLoadingImpl _value,
      $Res Function(_$InterventionStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InterventionStateLoadingImpl implements _InterventionStateLoading {
  _$InterventionStateLoadingImpl();

  @override
  String toString() {
    return 'InterventionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
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
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _InterventionStateLoading implements InterventionState {
  factory _InterventionStateLoading() = _$InterventionStateLoadingImpl;
}

/// @nodoc
abstract class _$$InterventionStateSucessImplCopyWith<$Res> {
  factory _$$InterventionStateSucessImplCopyWith(
          _$InterventionStateSucessImpl value,
          $Res Function(_$InterventionStateSucessImpl) then) =
      __$$InterventionStateSucessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<StreetLightInformation> response});
}

/// @nodoc
class __$$InterventionStateSucessImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res, _$InterventionStateSucessImpl>
    implements _$$InterventionStateSucessImplCopyWith<$Res> {
  __$$InterventionStateSucessImplCopyWithImpl(
      _$InterventionStateSucessImpl _value,
      $Res Function(_$InterventionStateSucessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$InterventionStateSucessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<StreetLightInformation>,
    ));
  }
}

/// @nodoc

class _$InterventionStateSucessImpl implements _InterventionStateSucess {
  _$InterventionStateSucessImpl({required this.response});

  @override
  final ResponseModel<StreetLightInformation> response;

  @override
  String toString() {
    return 'InterventionState.success(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStateSucessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionStateSucessImplCopyWith<_$InterventionStateSucessImpl>
      get copyWith => __$$InterventionStateSucessImplCopyWithImpl<
          _$InterventionStateSucessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return success(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return success?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
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
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _InterventionStateSucess implements InterventionState {
  factory _InterventionStateSucess(
          {required final ResponseModel<StreetLightInformation> response}) =
      _$InterventionStateSucessImpl;

  ResponseModel<StreetLightInformation> get response;
  @JsonKey(ignore: true)
  _$$InterventionStateSucessImplCopyWith<_$InterventionStateSucessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InterventionStateStoreSucessImplCopyWith<$Res> {
  factory _$$InterventionStateStoreSucessImplCopyWith(
          _$InterventionStateStoreSucessImpl value,
          $Res Function(_$InterventionStateStoreSucessImpl) then) =
      __$$InterventionStateStoreSucessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<dynamic> response});
}

/// @nodoc
class __$$InterventionStateStoreSucessImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res,
        _$InterventionStateStoreSucessImpl>
    implements _$$InterventionStateStoreSucessImplCopyWith<$Res> {
  __$$InterventionStateStoreSucessImplCopyWithImpl(
      _$InterventionStateStoreSucessImpl _value,
      $Res Function(_$InterventionStateStoreSucessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$InterventionStateStoreSucessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<dynamic>,
    ));
  }
}

/// @nodoc

class _$InterventionStateStoreSucessImpl
    implements _InterventionStateStoreSucess {
  _$InterventionStateStoreSucessImpl({required this.response});

  @override
  final ResponseModel<dynamic> response;

  @override
  String toString() {
    return 'InterventionState.storeSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStateStoreSucessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionStateStoreSucessImplCopyWith<
          _$InterventionStateStoreSucessImpl>
      get copyWith => __$$InterventionStateStoreSucessImplCopyWithImpl<
          _$InterventionStateStoreSucessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return storeSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return storeSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (storeSuccess != null) {
      return storeSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return storeSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return storeSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (storeSuccess != null) {
      return storeSuccess(this);
    }
    return orElse();
  }
}

abstract class _InterventionStateStoreSucess implements InterventionState {
  factory _InterventionStateStoreSucess(
          {required final ResponseModel<dynamic> response}) =
      _$InterventionStateStoreSucessImpl;

  ResponseModel<dynamic> get response;
  @JsonKey(ignore: true)
  _$$InterventionStateStoreSucessImplCopyWith<
          _$InterventionStateStoreSucessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateSuccessImplCopyWith<$Res> {
  factory _$$UpdateSuccessImplCopyWith(
          _$UpdateSuccessImpl value, $Res Function(_$UpdateSuccessImpl) then) =
      __$$UpdateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ResponseModel<dynamic> response});
}

/// @nodoc
class __$$UpdateSuccessImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res, _$UpdateSuccessImpl>
    implements _$$UpdateSuccessImplCopyWith<$Res> {
  __$$UpdateSuccessImplCopyWithImpl(
      _$UpdateSuccessImpl _value, $Res Function(_$UpdateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$UpdateSuccessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ResponseModel<dynamic>,
    ));
  }
}

/// @nodoc

class _$UpdateSuccessImpl implements _UpdateSuccess {
  _$UpdateSuccessImpl({required this.response});

  @override
  final ResponseModel<dynamic> response;

  @override
  String toString() {
    return 'InterventionState.updateSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSuccessImplCopyWith<_$UpdateSuccessImpl> get copyWith =>
      __$$UpdateSuccessImplCopyWithImpl<_$UpdateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return updateSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return updateSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return updateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return updateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(this);
    }
    return orElse();
  }
}

abstract class _UpdateSuccess implements InterventionState {
  factory _UpdateSuccess({required final ResponseModel<dynamic> response}) =
      _$UpdateSuccessImpl;

  ResponseModel<dynamic> get response;
  @JsonKey(ignore: true)
  _$$UpdateSuccessImplCopyWith<_$UpdateSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InterventionStateFailedImplCopyWith<$Res> {
  factory _$$InterventionStateFailedImplCopyWith(
          _$InterventionStateFailedImpl value,
          $Res Function(_$InterventionStateFailedImpl) then) =
      __$$InterventionStateFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$InterventionStateFailedImplCopyWithImpl<$Res>
    extends _$InterventionStateCopyWithImpl<$Res, _$InterventionStateFailedImpl>
    implements _$$InterventionStateFailedImplCopyWith<$Res> {
  __$$InterventionStateFailedImplCopyWithImpl(
      _$InterventionStateFailedImpl _value,
      $Res Function(_$InterventionStateFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$InterventionStateFailedImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InterventionStateFailedImpl implements _InterventionStateFailed {
  _$InterventionStateFailedImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'InterventionState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStateFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionStateFailedImplCopyWith<_$InterventionStateFailedImpl>
      get copyWith => __$$InterventionStateFailedImplCopyWithImpl<
          _$InterventionStateFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ResponseModel<StreetLightInformation> response)
        success,
    required TResult Function(ResponseModel<dynamic> response) storeSuccess,
    required TResult Function(ResponseModel<dynamic> response) updateSuccess,
    required TResult Function(String error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ResponseModel<StreetLightInformation> response)? success,
    TResult? Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult? Function(ResponseModel<dynamic> response)? updateSuccess,
    TResult? Function(String error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ResponseModel<StreetLightInformation> response)? success,
    TResult Function(ResponseModel<dynamic> response)? storeSuccess,
    TResult Function(ResponseModel<dynamic> response)? updateSuccess,
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
    required TResult Function(_InterventionStateInitial value) initial,
    required TResult Function(_InterventionStateLoading value) loading,
    required TResult Function(_InterventionStateSucess value) success,
    required TResult Function(_InterventionStateStoreSucess value) storeSuccess,
    required TResult Function(_UpdateSuccess value) updateSuccess,
    required TResult Function(_InterventionStateFailed value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InterventionStateInitial value)? initial,
    TResult? Function(_InterventionStateLoading value)? loading,
    TResult? Function(_InterventionStateSucess value)? success,
    TResult? Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult? Function(_UpdateSuccess value)? updateSuccess,
    TResult? Function(_InterventionStateFailed value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InterventionStateInitial value)? initial,
    TResult Function(_InterventionStateLoading value)? loading,
    TResult Function(_InterventionStateSucess value)? success,
    TResult Function(_InterventionStateStoreSucess value)? storeSuccess,
    TResult Function(_UpdateSuccess value)? updateSuccess,
    TResult Function(_InterventionStateFailed value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _InterventionStateFailed implements InterventionState {
  factory _InterventionStateFailed({required final String error}) =
      _$InterventionStateFailedImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$InterventionStateFailedImplCopyWith<_$InterventionStateFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
