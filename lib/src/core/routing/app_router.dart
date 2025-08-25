import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/classes/reseau.dart';
import 'package:sopaki_app/src/features/equipement/ui/component/street_light_component_parc.dart';
import 'package:sopaki_app/src/features/equipement/ui/equipement_maintenance_screen.dart';
import 'package:sopaki_app/src/features/equipement/ui/equipement_screen.dart';
import 'package:sopaki_app/src/features/equipement/ui/equipment_details_screen.dart';
import 'package:sopaki_app/src/features/equipement/ui/network_details_screen.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/login/ui/login_screen.dart';
import 'package:sopaki_app/src/features/map/ui/map_screen.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/mission/ui/mission_screen.dart';
import 'package:sopaki_app/src/features/photo/ui/photo_screen.dart';
import 'package:sopaki_app/src/features/profil/ui/profil_screen.dart';
import 'package:sopaki_app/src/features/splashscreen/splash_screen.dart';
import 'package:sopaki_app/src/features/vue_parc/ui/vue_parc_screen.dart';

import '../../features/armoire/ui/armoire_deploiement_screen.dart';
import '../../features/compteur/ui/compteur_deploiement_screen.dart';
import '../../features/lampadaire/ui/lampadaire_screen.dart';
import '../../features/qrcode/ui/qrcode_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: MissionRoute.page),
    AutoRoute(page: LampadaireRoute.page),
    AutoRoute(page: CompteurDeploiementFormRoute.page),
    AutoRoute(page: ArmoireDeploiementFormRoute.page),
    AutoRoute(page: QrcodeRoute.page),
    AutoRoute(page: PhotoRoute.page),
    AutoRoute(page: MapRoute.page),
    AutoRoute(page: EquipementRoute.page),
    AutoRoute(page: EquipmentDetailsRoute.page),
    AutoRoute(page: UserProfileRoute.page),
    AutoRoute(page: NetworkDetailsRoute.page,),
    AutoRoute(page: GlobalMapRoute.page,),
    AutoRoute(page: MaintenanceEquipmentRoute.page,),
    AutoRoute(page: StreetLightComponentCompletRoute.page,),
    
  ];
}
