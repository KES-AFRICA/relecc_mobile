import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';
import 'colors.dart';

class AppDrawer extends StatefulWidget {
  final int selected;

  const AppDrawer({super.key, required this.selected});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PreferencesService preferencesService = locator<PreferencesService>();
  String? userName;
  String? userRole;
  String? usercompany;
  
  @override
  void initState() {
    super.initState();
    userName = preferencesService.getUserNameKey();
    userRole = preferencesService.getUserRoleKey();
    usercompany = preferencesService.getUserCompanyKey();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const Border(),
      backgroundColor: primaryColor,
      shadowColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 2 * screenHeight(context) / 5,
            width: double.maxFinite,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.router.popAndPush(UserProfileRoute());
                  },
                  child: CircleAvatar(
                    radius: largeur(context, 80),
                    backgroundColor: Colors.lightBlue.shade100,
                    child: Image.asset('assets/images/avatar2.png'),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName ?? "",
                      style: TextStyle(
                        color: textBoldColor,
                        fontSize: hauteur(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${userRole ?? ""} - ${usercompany ?? ""}",
                      style: TextStyle(
                        color: textBoldColor,
                        fontSize: hauteur(context, 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3 * screenHeight(context) / 5,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.selected == 1
                    ? ListTile(
                        leading: const Icon(
                          Icons.home,
                        ),
                        selected: true,
                        selectedColor: secondaryColor,
                        title: Text(
                          "Accueil",
                          style: TextStyle(fontSize: hauteur(context, 15)),
                        ),
                        onTap: () {
                          context.router.replace(MissionRoute());
                        },
                      )
                    : ListTile(
                        leading: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        selected: true,
                        selectedColor: secondaryColor,
                        title: Text(
                          "Accueil",
                          style: TextStyle(
                              fontSize: hauteur(context, 15),
                              color: Colors.white),
                        ),
                         onTap: () {
                          context.router.replace(MissionRoute());
                        },
                      ),
                // widget.selected == 2
                //     ? ListTile(
                //         leading: const Icon(
                //           Icons.do_disturb_alt,
                //         ),
                //         selected: true,
                //         selectedColor: secondaryColor,
                //         title: Text(
                //           "Anomalies",
                //           style: TextStyle(fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       )
                //     : ListTile(
                //         leading: const Icon(
                //           Icons.do_disturb_alt,
                //           color: Colors.white,
                //         ),
                //         title: Text(
                //           "Anomalies",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       ),
                widget.selected == 3
                    ? ListTile(
                        leading: const Icon(
                          Icons.map_outlined,
                        ),
                        selected: true,
                        selectedColor: secondaryColor,
                        title: Text(
                          "Vue globale du parc",
                          style: TextStyle(fontSize: hauteur(context, 15)),
                        ),
                        onTap: () {
                          // context.router.replace(MapRoute());
                          context.router.replace(GlobalMapRoute());
                          
                        },
                      )
                    : ListTile(
                        leading: const Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Vue globale du parc",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: hauteur(context, 15)),
                        ),
                        onTap: () {
                          // context.router.replace(MapRoute());
                          context.router.replace(GlobalMapRoute());
                        },
                      ),
                // widget.selected == 4
                //     ? ListTile(
                //         leading: const Icon(
                //           Icons.live_help_outlined,
                //         ),
                //         selected: true,
                //         selectedColor: secondaryColor,
                //         title: Text(
                //           "A propos",
                //           style: TextStyle(fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       )
                //     : ListTile(
                //         leading: const Icon(
                //           Icons.live_help_outlined,
                //           color: Colors.white,
                //         ),
                //         title: Text(
                //           "A propos",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       ),
                // widget.selected == 5
                //     ? ListTile(
                //         leading: const Icon(
                //           Icons.report,
                //         ),
                //         selected: true,
                //         selectedColor: secondaryColor,
                //         title: Text(
                //           "Rapport",
                //           style: TextStyle(fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       )
                //     : ListTile(
                //         leading: const Icon(
                //           Icons.report,
                //           color: Colors.white,
                //         ),
                //         title: Text(
                //           "Rapport",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: hauteur(context, 15)),
                //         ),
                //         onTap: () {
                //         },
                //       ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}