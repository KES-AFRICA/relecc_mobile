part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  factory UserState.initial() = _UserInitial;

  factory UserState.loading() = _Useroading;

  factory UserState.success({required ResponseModel<UserProfil> response}) = _UserSucess;

  factory UserState.failure({required String error}) = _UserFailed;
}
