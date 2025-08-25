
// Importations des bibliothèques Flutter, Hive, et des modèles de données de l'application.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

// Importation des modèles pour Hive (sérialisation/désérialisation locale)
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/login/logic/local_storage/model/login_local_storage.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';
import 'package:sopaki_app/src/shared/model/roles/role.model.dart';
import 'package:sopaki_app/src/shared/model/user/user.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';


class AppInitializer {
  /// Initialize services, plugins, etc. before the app runs.
  /// Résumé :
  // Configure l’interface utilisateur pour un affichage plein écran.
  // Initialise les préférences utilisateur via un service injecté avec locator.
  Future<void> preAppRun() async {
    // Met l'UI en mode "edge-to-edge" (le contenu peut s'étendre sous la barre de statut/navigation)
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Initialise le service de préférences partagé (SharedPreferences ou équivalent)
    await locator<PreferencesService>().init();
  }

  /// Initialize services, plugins, etc. after the app runs.
  /// Résumé :
  //Masque les erreurs à l’écran dans les builds de production pour éviter que l'utilisateur voie des crashs non gérés.
  Future<void> postAppRun() async {
    // En mode release uniquement, on remplace les widgets d’erreur par un widget vide (évite les erreurs visibles)
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) => const SizedBox();
    }
  }


  //Résumé :
  //Initialise la base de données locale Hive.
  //Enregistre les adaptateurs pour chaque modèle de données utilisé (nécessaire pour Hive).
  //Ouvre une boîte de données offline_relec_data pour le stockage local hors ligne.
  Future<void> localStorageInitializer() async {
    // Récupère le chemin de stockage de l'application
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Initialise Hive avec ce répertoire
    await Hive.initFlutter(appDocumentDir.path);

    // Enregistre les adaptateurs Hive pour les différents modèles utilisés
    Hive.registerAdapter(LoginLocalStorageAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(RoleAdapter());
    Hive.registerAdapter(EquipmentResponseAdapter());
    Hive.registerAdapter(StoreStreetLampInformationAdapter());
    Hive.registerAdapter(StoreStreetLightInformationAdapter());
    Hive.registerAdapter(StreetLightInformationAdapter());
    Hive.registerAdapter(CommonAdapter());
    Hive.registerAdapter(MissionAdapter());
    Hive.registerAdapter(MissionResponseAdapter());
    Hive.registerAdapter(CabinetAdapter());
    Hive.registerAdapter(CabinetResponseAdapter());
    Hive.registerAdapter(MeterAdapter());
    Hive.registerAdapter(MeterActionAdapter());
    Hive.registerAdapter(MeterResponseAdapter());

    // Ouvre une boîte Hive pour stocker les données hors ligne
    await Hive.openBox('offline_relec_data');
  }

}
