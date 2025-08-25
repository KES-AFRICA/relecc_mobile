import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PreferencesService preferencesService = locator<PreferencesService>();


  @override
  void initState() {
    String? token = preferencesService.getLoginAccessToken();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        (token != null)
            ? context.router.replaceAll([MissionRoute(source: SourceProvider.SplashProvider)])
            : context.router.replaceAll([const LoginRoute()]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesLogo),
            LoadingAnimationWidget.fourRotatingDots(
              color: context.colorScheme.primary,
              size: 32,
          )
        ],
      )),
    );
  }
}
