import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sopaki_app/src/features/profil/logic/controller/repository/profil_repository.dart';
import 'package:sopaki_app/src/features/profil/logic/model/user_profil.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({
    PreferencesService? preferencesService,
    UserRepository? userRepository,
  })  : _userRepository = userRepository ?? locator<UserRepository>(),
        super(UserState.initial());

  void getUserData() async {
    emit(UserState.loading());
    try {
      final response = await _userRepository.getUserData();
      emit(UserState.success(response: response));
    } catch (error) {
      emit(UserState.failure(error: error.toString()));
    }
  }
}
