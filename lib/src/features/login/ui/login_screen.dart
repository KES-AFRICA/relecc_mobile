import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/i18n/l10n.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/login/logic/controller/bloc/login_cubit.dart';
import 'package:sopaki_app/src/service/offline/offline_storage.dart';
import 'package:sopaki_app/src/shared/components/buttons/button.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/components/forms/input.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/model/user/user.model.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => LoginCubit(),
      ),
    ], child: this);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;
  late TextEditingController _emailOrUserNameController;
  late TextEditingController _passwordController;

  final storage = OfflineStorage();

  getDiveceInfo()async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
  }

  @override
  void initState() {
    _emailOrUserNameController = TextEditingController();
    _passwordController = TextEditingController();
    getDiveceInfo();
    super.initState();
  }

  @override
  void dispose() {
    _emailOrUserNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> localStorageLoginData(User userData) async {
    await storage.saveOfflineData(userData);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => LoadingDialog.show(context: context),
              success: (response) {
                localStorageLoginData(response.data!.user!);
                LoadingDialog.hide(context: context);
                context.router.replaceAll([ MissionRoute(source: SourceProvider.LoginProvider)]);
              },
              failure: (error) {
                LoadingDialog.hide(context: context);
                ApiErrorDialog.show(context: context, error: error);
              },
            );
          },
        )
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image.asset(Assets.imagesLogo),
                          ),
                          Input(
                            labelColor: Colors.black,
                            controller: _emailOrUserNameController,
                            labelText: I18n.of(context).login_email,
                            hintStyle: Theme.of(context).primaryTextTheme.bodySmall,
                            cursorColor: context.colorScheme.primary,
                            fillColor: context.colorScheme.primary.withOpacity(0.05),
                            style:
                                Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(color: context.colorScheme.shadow),
                            textCapitalization: TextCapitalization.none,
                            filled: true,
                            maxLines: 1,
                            minLines: 1,
                            validator: ValidationBuilder().required().email(I18n.of(context).login_email_not_good).build(),
                          ),
                          const SizedBox(height: Dimens.spacing),
                          Input(
                            controller: _passwordController,
                            isPassword: _isPasswordVisible,
                            labelColor: Colors.black,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible ? IconsaxPlusBold.eye_slash : IconsaxPlusBold.eye,
                                color: context.colorScheme.primary,
                                size: Dimens.iconSizeM,
                              ),
                            ),
                            validator: ValidationBuilder().required().build(),
                            labelText: I18n.of(context).login_password,
                            hintStyle: Theme.of(context).primaryTextTheme.bodySmall,
                            cursorColor: context.colorScheme.primary,
                            fillColor: context.colorScheme.primary.withOpacity(0.05),
                            style:
                                Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(color: context.colorScheme.shadow),
                            filled: true,
                            textCapitalization: TextCapitalization.none,
                            maxLines: 1,
                            minLines: 1,
                          ),
                          const SizedBox(height: Dimens.doubleSpacing),
                          Button.primary(
                              title: I18n.of(context).login_login,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().getUserLogin(
                                      email: _emailOrUserNameController.text, password: _passwordController.text);
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
