// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
// import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
// import 'package:sopaki_app/src/service/env.dart';
// import 'package:sopaki_app/src/service/exceptions.dart';
// import 'package:sopaki_app/src/shared/locator.dart';
// import 'package:sopaki_app/src/shared/model/response/response.model.dart';
// import 'package:sopaki_app/src/shared/services/preferences_service.dart';
// import 'package:logger/logger.dart';

// // Configuration du logger
// final _logger = Logger(
//   printer: PrettyPrinter(),
// );

// class MissionRepository {
//   static const int _requestTimeoutSeconds = 30;
//   final Dio _dio;
//   final PreferencesService _preferencesService = locator<PreferencesService>();

//   // Cache en mémoire
//   List<Mission>? _cachedMissions;
//   Map<int, EquipmentResponse> _cachedEquipmentByMission = {};
//   DateTime? _lastMissionFetchTime;
//   DateTime? _lastEquipmentFetchTime;
//   final Duration _cacheDuration = Duration(minutes: 5);

//   MissionRepository({Dio? dio}) : _dio = dio ?? Dio() {
//     _dio.options
//       ..connectTimeout = Duration(seconds: _requestTimeoutSeconds)
//       ..receiveTimeout = Duration(seconds: _requestTimeoutSeconds)
//       ..sendTimeout = Duration(seconds: _requestTimeoutSeconds);
//   }

//   Future<String?> _getAuthToken() async {
//     return _preferencesService.getLoginAccessToken();
//   }

//   Options _buildOptions(String? token) {
//     return Options(
//       headers: {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//         if (token != null) "Authorization": "Bearer $token",
//       },
//     );
//   }

//   Future<ResponseModelWithList<Mission>> getAllMission() async {
//     final token = await _getAuthToken();
//     final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}agent-missions');

//     // Vérifier si le cache est encore valide
//     final now = DateTime.now();
//     if (_cachedMissions != null && 
//         _lastMissionFetchTime != null && 
//         now.difference(_lastMissionFetchTime!) < _cacheDuration) {
//       _logger.i("Returning cached missions data");
//       return ResponseModelWithList<Mission>(
//         success: true,
//         error: false,
//         status: 200,
//         message: "Data loaded from cache",
//         data: _cachedMissions!,
//       );
//     }

//     final stopwatch = Stopwatch()..start();

//     try {
//       _logger.i("Starting GET request to: $url");

//       final response = await _dio.get(
//         url,
//         options: _buildOptions(token),
//       ).timeout(Duration(seconds: _requestTimeoutSeconds));

//       _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

//       final result = ResponseModelWithList<Mission>.fromJson(
//         response.data,
//         (data) => Mission.fromJson(data as Map<String, dynamic>),
//       );

//       // Mettre à jour le cache
//       _cachedMissions = result.data;
//       _lastMissionFetchTime = DateTime.now();
      
//       // Sauvegarder aussi dans le stockage local
//       await _preferencesService.setMissionsCache(response.data.toString());
//       await _preferencesService.setMissionsCacheTime(_lastMissionFetchTime!.toIso8601String());

//       return result;
//     } on TimeoutException catch (_) {
//       _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      
//       // Essayer de retourner le cache si disponible
//       if (_cachedMissions != null) {
//         _logger.w("Returning cached data due to timeout");
//         return ResponseModelWithList<Mission>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to timeout",
//           data: _cachedMissions!,
//         );
//       }
//       throw TimeoutException("Request took too long");
//     } on DioException catch (e) {
//       _logger.f("Dio error: ${e.message}");
      
//       // Essayer de retourner le cache si disponible
//       if (_cachedMissions != null) {
//         _logger.w("Returning cached data due to API error");
//         return ResponseModelWithList<Mission>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to API error: ${e.message}",
//           data: _cachedMissions!,
//         );
//       }
//       throw handleDioError(e);
//     } catch (e, stacktrace) {
//       _logger.f("Unexpected error: $e\nStacktrace: $stacktrace");
      
//       if (_cachedMissions != null) {
//         _logger.w("Returning cached data due to unexpected error");
//         return ResponseModelWithList<Mission>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to error: $e",
//           data: _cachedMissions!,
//         );
//       }
//       throw BadRequestException(
//         message: "Unexpected error occurred: $e",
//       );
//     } finally {
//       stopwatch.stop();
//     }
//   }

//   Future<ResponseModel<EquipmentResponse>> getAllEquipmentOfMission(int missionId) async {
//     final token = await _getAuthToken();
//     final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}missions-equipments');

//     // Vérifier le cache
//     final now = DateTime.now();
//     if (_cachedEquipmentByMission.containsKey(missionId) ){
//       final lastFetch = _lastEquipmentFetchTime;
//       if (lastFetch != null && now.difference(lastFetch) < _cacheDuration) {
//         _logger.i("Returning cached equipment data for mission $missionId");
//         return ResponseModel<EquipmentResponse>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Data loaded from cache",
//           data: _cachedEquipmentByMission[missionId]!,
//         );
//       }
//     }

//     final stopwatch = Stopwatch()..start();

//     try {
//       _logger.i("Starting POST request to: $url with mission_id: $missionId");

//       final response = await _dio.post(
//         url,
//         data: {'mission_id': missionId},
//         options: _buildOptions(token),
//       ).timeout(Duration(seconds: _requestTimeoutSeconds));

//       _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");
      
//       final result = ResponseModel<EquipmentResponse>.fromJson(
//         response.data,
//         (data) => EquipmentResponse.fromJson(data as Map<String, dynamic>),
//       );

//       // Mettre à jour le cache
//       _cachedEquipmentByMission[missionId] = result.data!;
//       _lastEquipmentFetchTime = DateTime.now();
      
//       // Sauvegarder dans le stockage local
//       await _preferencesService.setEquipmentCacheForMission(
//         missionId.toString(), 
//         response.data.toString()
//       );
//       await _preferencesService.setEquipmentCacheTime(
//         missionId.toString(),
//         _lastEquipmentFetchTime!.toIso8601String()
//       );

//       return result;
//     } on TimeoutException catch (_) {
//       _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      
//       // Retourner le cache si disponible
//       if (_cachedEquipmentByMission.containsKey(missionId)) {
//         _logger.w("Returning cached equipment data due to timeout");
//         return ResponseModel<EquipmentResponse>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to timeout",
//           data: _cachedEquipmentByMission[missionId]!,
//         );
//       }
//       throw TimeoutException("Request took too long");
//     } on DioException catch (e) {
//       _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      
//       // Retourner le cache si disponible
//       if (_cachedEquipmentByMission.containsKey(missionId)) {
//         _logger.w("Returning cached equipment data due to API error");
//         return ResponseModel<EquipmentResponse>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to API error: ${e.message}",
//           data: _cachedEquipmentByMission[missionId]!,
//         );
//       }
//       throw handleDioError(e);
//     } catch (e, stacktrace) {
//       _logger.f("Unexpected error: $e\nStacktrace: $stacktrace");
      
//       // Retourner le cache si disponible
//       if (_cachedEquipmentByMission.containsKey(missionId)) {
//         _logger.w("Returning cached equipment data due to unexpected error");
//         return ResponseModel<EquipmentResponse>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to error: $e",
//           data: _cachedEquipmentByMission[missionId]!,
//         );
//       }
//       throw BadRequestException(
//         message: "Unexpected error occurred: $e",
//       );
//     } finally {
//       stopwatch.stop();
//     }
//   }

//   // Méthode pour forcer le rafraîchissement des données
//   Future<void> refreshCache() async {
//     _cachedMissions = null;
//     _cachedEquipmentByMission.clear();
//     _lastMissionFetchTime = null;
//     _lastEquipmentFetchTime = null;
    
//     // Nettoyer aussi le stockage local
//     await _preferencesService.clearMissionsCache();
//     await _preferencesService.clearEquipmentCache();
//   }

//   // Méthode pour notifier un changement d'équipement
//   Future<void> notifyEquipmentChange(int missionId) async {
//     // Invalider le cache pour cette mission
//     _cachedEquipmentByMission.remove(missionId);
//     await _preferencesService.clearEquipmentCacheForMission(missionId.toString());
//   }

//   // Méthode pour notifier un changement de mission
//   Future<void> notifyMissionChange() async {
//     // Invalider le cache des missions
//     _cachedMissions = null;
//     _lastMissionFetchTime = null;
//     await _preferencesService.clearMissionsCache();
//   }

//   String getControllerName() => 'missions/';
// }

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipement_maintenance.modal.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/service/env.dart';
import 'package:sopaki_app/src/service/exceptions.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';
import 'package:logger/logger.dart';

// Configuration du logger
final _logger = Logger(
  printer: PrettyPrinter(),
);


class MissionRepository {
  static const int _requestTimeoutSeconds = 30; // Timeout pour toutes les requêtes
  final Dio _dio;

  MissionRepository({Dio? dio}) : _dio = dio ?? Dio() {
    // Configuration globale de Dio
    _dio.options
      ..connectTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..receiveTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..sendTimeout = Duration(seconds: _requestTimeoutSeconds);
  }

  // Méthode utilitaire pour obtenir le token
  Future<String?> _getAuthToken() async {
    final preferencesService = locator<PreferencesService>();
    return preferencesService.getLoginAccessToken();
  }

  // Méthode utilitaire pour créer les headers avec token
  Options _buildOptions(String? token) {
    return Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
  }

  Future<ResponseModelWithList<Mission>> getAllMission() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}agent-missions');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModelWithList<Mission>.fromJson(
        response.data,
            (data) => Mission.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.f("Dio error: ${e.message}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      _logger.f("Unexpected error: $e\nStacktrace: $stacktrace");
      throw BadRequestException(
        message: "Unexpected error occurred: $e",
      );
    } finally {
      stopwatch.stop();
    }
  }

  Future<ResponseModel<EquipmentResponse>> getAllEquipmentOfMission(int missionId) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}missions-equipments');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting POST request to: $url with mission_id: $missionId");

      final response = await _dio.post(
        url,
        data: {'mission_id': missionId},
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");
      
      // Ajout du console.log pour afficher les données brutes
      print("----------------------------------------");
      print("DONNÉES BRUTES DE L'API (getAllEquipmentOfMission):");
      print("URL: $url");
      print("Mission ID: $missionId");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Données complètes:");
      print(response.data);
      print("----------------------------------------");

      return ResponseModel<EquipmentResponse>.fromJson(
        response.data,
            (data) => EquipmentResponse.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      // Ajout du log pour les erreurs Dio
      print("----------------------------------------");
      print("ERREUR DIO (getAllEquipmentOfMission):");
      print("URL: $url");
      print("Mission ID: $missionId");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      print("----------------------------------------");
      
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      // Ajout du log pour les autres erreurs
      print("----------------------------------------");
      print("ERREUR INATTENDUE (getAllEquipmentOfMission):");
      print("URL: $url");
      print("Mission ID: $missionId");
      print("Error: $e");
      print("Stacktrace: $stacktrace");
      print("----------------------------------------");
      
      _logger.f("Unexpected error: $e\nStacktrace: $stacktrace");
      throw BadRequestException(
        message: "Unexpected error occurred: $e",
      );
    } finally {
      stopwatch.stop();
    }
  }

  Future<ResponseModel<EquipmentMaintenanceResponse>> getAllEquipmentOfMissionMaintenance(int missionId) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}missionsMaintenanceEquipments');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting POST request to: $url with mission_id: $missionId");

      final response = await _dio.post(
        url,
        data: {'mission_id': missionId},
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");
      print("données du get ${response.data}");
      return ResponseModel<EquipmentMaintenanceResponse>.fromJson(
        response.data,
            (data) => EquipmentMaintenanceResponse.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      _logger.f("Unexpected error: $e\nStacktrace: $stacktrace");
      throw BadRequestException(
        message: "Unexpected error occurred: $e",
      );
    } finally {
      stopwatch.stop();
    }
  }


  String getControllerName() => 'missions/';
}