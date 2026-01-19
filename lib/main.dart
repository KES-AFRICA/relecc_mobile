import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/app_initializer.dart';
import 'package:sopaki_app/src/core/sopaki.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopaki_app/src/service/app_bloc_observer.dart';
// import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';


void main() {
  final AppInitializer appInitializer = AppInitializer();

  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized(); // Assure l'initialisation du moteur Flutter
      
      Bloc.observer = AppBlocObserver(); // Permet de suivre tous les changements d'état BLoC

      await appInitializer.preAppRun(); // Initialisations avant le lancement de l'app

      appInitializer.postAppRun(); // Logique post-lancement
      appInitializer.localStorageInitializer(); // Initialisation du stockage local (SharedPreferences par ex.)

      runApp(Relec()); // Lancement de l'application (widget racine)
    },
        (error, stack) {
      // Gestion des erreurs globales (tu pourrais logger ici)
      debugPrint('Erreur non gérée : $error');
    },
  );
}
