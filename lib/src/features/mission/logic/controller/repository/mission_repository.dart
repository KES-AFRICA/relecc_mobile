import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipement_maintenance.modal.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/network/logic/model/network_analysis_response.dart';
import 'package:sopaki_app/src/features/network/logic/model/network_filter_options_response.dart';
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

Future<ResponseModel<EquipmentResponse>> getAllEquipmentOfMission(
  int missionId, {
  int page = 1,
  int perPage = 10,
  String? equipmentType,
}) async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}missions-equipments');

  final stopwatch = Stopwatch()..start();

  try {
    _logger.i("Starting POST request to: $url with mission_id: $missionId, page: $page, per_page: $perPage");

    final response = await _dio.post(
      url,
      data: {
        'mission_id': missionId,
        'page': page,
        'per_page': perPage,
        if (equipmentType != null) 'equipment_type': equipmentType,
      },
      options: _buildOptions(token),
    ).timeout(Duration(seconds: _requestTimeoutSeconds));

    _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");
    
    print("----------------------------------------");
    print("DONNÉES BRUTES DE L'API (getAllEquipmentOfMission):");
    print("URL: $url");
    print("Mission ID: $missionId");
    print("Page: $page");
    print("Per Page: $perPage");
    print("Type: $equipmentType");
    print("Status Code: ${response.statusCode}");
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
    print("----------------------------------------");
    print("ERREUR DIO (getAllEquipmentOfMission):");
    print("URL: $url");
    print("Mission ID: $missionId");
    print("Page: $page");
    print("Per Page: $perPage");
    print("Error: ${e.message}");
    print("Response: ${e.response?.data}");
    print("----------------------------------------");
    
    _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
    throw handleDioError(e);
  } catch (e, stacktrace) {
    print("----------------------------------------");
    print("ERREUR INATTENDUE (getAllEquipmentOfMission):");
    print("URL: $url");
    print("Mission ID: $missionId");
    print("Page: $page");
    print("Per Page: $perPage");
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

Future<ResponseModel<NetworkAnalysisData>> analyzeNetworks({
  int page = 1,
  int perPage = 10,
  String? type,
  String? municipality,
}) async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/network-analysis');

  try {
    final response = await _dio.get(
      url,
      queryParameters: {
        'page': page,
        'per_page': perPage,
        if (type != null) 'type': type,
        if (municipality != null) 'municipality': municipality,
      },
      options: _buildOptions(token),
    ).timeout(Duration(seconds: _requestTimeoutSeconds));

    print("----------------------------------------");
    print("DONNÉES BRUTES DE L'API (analyzeNetworks):");
    print("URL: $url");
    print("Données complètes:");
    print(response.data);
    print("----------------------------------------");

    // CORRECTION ICI : On extrait le "data" du ResponseModel
    return ResponseModel<NetworkAnalysisData>.fromJson(
      response.data,
      (data) => NetworkAnalysisData.fromJson(data as Map<String, dynamic>),
    );
  } catch (e) {
    print("Erreur API: $e");
    rethrow;
  }
}

  Future<ResponseModel<NetworkFilterOptionsResponse>> getNetworkFilterOptions() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/network-analysis/filter-options');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
      
      print("----------------------------------------");
      print("DONNÉES BRUTES DE L'API (getNetworkFilterOptions):");
      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Données complètes:");
      print(response.data);
      print("----------------------------------------");

      return ResponseModel<NetworkFilterOptionsResponse>.fromJson(
        response.data,
        (data) => NetworkFilterOptionsResponse.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      print("----------------------------------------");
      print("ERREUR DIO (getNetworkFilterOptions):");
      print("URL: $url");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      print("----------------------------------------");
      
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      print("----------------------------------------");
      print("ERREUR INATTENDUE (getNetworkFilterOptions):");
      print("URL: $url");
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

  Future<ResponseModel<Map<String, dynamic>>> getNetworkDetails({
    required String type,
    required String id,
  }) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/network-analysis/$type/$id');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
      
      print("----------------------------------------");
      print("DONNÉES BRUTES DE L'API (getNetworkDetails):");
      print("URL: $url");
      print("Type: $type");
      print("ID: $id");
      print("Status Code: ${response.statusCode}");
      print("Données complètes:");
      print(response.data);
      print("----------------------------------------");

      return ResponseModel<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      print("----------------------------------------");
      print("ERREUR DIO (getNetworkDetails):");
      print("URL: $url");
      print("Type: $type");
      print("ID: $id");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      print("----------------------------------------");
      
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      print("----------------------------------------");
      print("ERREUR INATTENDUE (getNetworkDetails):");
      print("URL: $url");
      print("Type: $type");
      print("ID: $id");
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

  Future<ResponseModel<Map<String, dynamic>>> getNetworkQuickStats() async {
    final token = await _getAuthToken();
    // Note: Cette route n'existe pas encore dans votre API, vous devrez l'ajouter
    final url = Uri.encodeFull('$API_ENDPOINT/network-analysis/quick-stats');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
      
      print("----------------------------------------");
      print("DONNÉES BRUTES DE L'API (getNetworkQuickStats):");
      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Données complètes:");
      print(response.data);
      print("----------------------------------------");

      return ResponseModel<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      print("----------------------------------------");
      print("ERREUR DIO (getNetworkQuickStats):");
      print("URL: $url");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      print("----------------------------------------");
      
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      print("----------------------------------------");
      print("ERREUR INATTENDUE (getNetworkQuickStats):");
      print("URL: $url");
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

  Future<ResponseModel<Map<String, dynamic>>> exportNetworks({
    String? type,
    String? municipality,
  }) async {
    final token = await _getAuthToken();
    // Note: Cette route n'existe pas encore dans votre API, vous devrez l'ajouter
    final url = Uri.encodeFull('$API_ENDPOINT/network-analysis/export');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        queryParameters: {
          if (type != null) 'type': type,
          if (municipality != null) 'municipality': municipality,
        },
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
      
      print("----------------------------------------");
      print("DONNÉES BRUTES DE L'API (exportNetworks):");
      print("URL: $url");
      print("Type: $type");
      print("Municipality: $municipality");
      print("Status Code: ${response.statusCode}");
      print("Données complètes:");
      print(response.data);
      print("----------------------------------------");

      return ResponseModel<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      print("----------------------------------------");
      print("ERREUR DIO (exportNetworks):");
      print("URL: $url");
      print("Error: ${e.message}");
      print("Response: ${e.response?.data}");
      print("----------------------------------------");
      
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      print("----------------------------------------");
      print("ERREUR INATTENDUE (exportNetworks):");
      print("URL: $url");
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


  String getControllerName() => 'missions/';
}