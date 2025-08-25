import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart' show LoginRoute;
import 'package:sopaki_app/src/features/profil/logic/controller/bloc/user_cubit.dart';
import 'package:sopaki_app/src/shared/components/app_drawer.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart' show ApiErrorDialog;
import 'package:sopaki_app/src/shared/locator.dart' show locator;
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart' show PreferencesService;

import '../../../shared/components/dialogs/dialog_builder.dart';

@RoutePage<void>()
class UserProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => UserCubit(),
      ),
    ], child: this);
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  PreferencesService preferencesService = locator<PreferencesService>();
  final String profileImageUrl = "assets/images/avatar2.png";
  // Remplacer par le vrai lien ou asset
  String? userName;

  String? userEmail;

  String? userRole;

  String? userPhone;

  String? usercompany;

  Widget buildUserInfo(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              )),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(hauteur(context, 2)),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    userName = preferencesService.getUserNameKey();
    userRole = preferencesService.getUserRoleKey();
    usercompany = preferencesService.getUserCompanyKey();
    userEmail = preferencesService.getUserEmailKey();
    userPhone = preferencesService.getUserTelephoneKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Mon Profil",
        ),
        drawer: const AppDrawer(selected: 1),
        body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.lightBlue.shade100,
                      backgroundImage: AssetImage(profileImageUrl),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userName ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userEmail ?? "",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 30),
                    buildUserInfo("Nom", userName ?? "", context),
                    buildUserInfo("Email", userEmail ?? "", context),
                    buildUserInfo("Téléphone", userPhone ?? "", context),
                    buildUserInfo("Compagnie", usercompany ?? "", context),
                    buildUserInfo("Rôle", userRole ?? "", context),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.13,
                      height: MediaQuery.of(context).size.height / 16,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action de déconnexion
                          preferencesService.removeAll();
                          context.router.replace(const LoginRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "Se déconnecter",
                          style: TextStyle(
                            fontSize: hauteur(context, 12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
