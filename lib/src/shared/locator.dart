
import 'package:get_it/get_it.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/controller/repository/armoire_repository.dart';
import 'package:sopaki_app/src/features/compteur/logic/controller/repository/compteur_repository.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/controller/repository/intervention_repository.dart';
import 'package:sopaki_app/src/features/login/logic/controller/repository/auth_repository.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/repository/mission_repository.dart';
import 'package:sopaki_app/src/features/profil/logic/controller/repository/profil_repository.dart';
import 'package:sopaki_app/src/features/vue_parc/logic/controller/repository/equipment_repository.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

final GetIt locator = GetIt.instance
  ..registerLazySingleton(() => AppRouter())
  ..registerLazySingleton(() => AuthRepository())
  ..registerLazySingleton(() => MissionRepository())
  ..registerLazySingleton(() => InterventionRepository())
  ..registerLazySingleton(() => ArmoireRepository())
  ..registerLazySingleton(() => CompteurRepository())
  ..registerLazySingleton(() => UserRepository())
  ..registerLazySingleton(() => PreferencesService())
  ..registerLazySingleton(() => EquipmentRepository());
