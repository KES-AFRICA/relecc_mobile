import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sopaki_app/src/features/login/logic/controller/repository/auth_repository.dart';
import 'package:sopaki_app/src/features/login/logic/model/login.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    PreferencesService? preferencesService,
    AuthRepository? authRepository,
  })  : _authRepository = authRepository ?? locator<AuthRepository>(),
        super(LoginState.initial());

  void getUserLogin({required String email, required String password}) async {
    emit(LoginState.loading());
    try {
      final response = await _authRepository.loginUserApp(request: Login(email: email, password: password));
      emit(LoginState.success(response: response));
    } catch (error) {
      emit(LoginState.failure(error: error.toString()));
    }
  }
}
