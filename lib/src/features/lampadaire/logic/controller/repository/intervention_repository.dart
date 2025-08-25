import 'dart:async';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
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

class InterventionRepository {
  static const int _requestTimeoutSeconds = 30; // Timeout pour toutes les requêtes
  final Dio _dio;

  InterventionRepository({Dio? dio}) : _dio = dio ?? Dio() {
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

  Future<ResponseModel<StreetLightInformation>> getAllStreetLightInformation() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}create-streetlight');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio
          .get(
            url,
            options: _buildOptions(token),
          )
          .timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<StreetLightInformation>.fromJson(
        response.data,
        (data) => StreetLightInformation.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.w("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.e("Dio error: ${e.message}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      _logger.e("Unexpected error: $e\nStacktrace: $stacktrace");
      throw BadRequestException(
        message: "Unexpected error occurred: $e",
      );
    } finally {
      stopwatch.stop();
    }
  }

  Future<ResponseModel<StoreStreetLightResponse>> createStreetLightInformation({
    required XFile photo,
    required StoreStreetLightInformation storeStreetLight,
  }) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}store-streetlight');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting POST request to: $url");

      // Préparation des lampes sous forme de liste de Maps
      final lampsData = storeStreetLight.lamps?.map((lamp) {
            return {
              'lamp_type_id': lamp.lampTypeId,
              'power': lamp.power,
              'color_id': lamp.colorId,
              'has_lamp': lamp.hasLamp,
              'with_balast': lamp.withbalast,
              'is_on_day': lamp.isOnDay,
              'is_on_night': lamp.isOnNight,
            };
          }).toList() ??
          [];

      // Création du FormData
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: 'streetlight_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'qrcode': storeStreetLight.qrcode,
        'streetlight_type_id': storeStreetLight.streetlighttypeId,
        'network_id': storeStreetLight.networkId,
        'orientation_id': storeStreetLight.orientationId,
        'track_id': storeStreetLight.trackId,
        'street': storeStreetLight.street,
        'command_type_id': storeStreetLight.commandTypeId,
        'support_type_id': storeStreetLight.supportTypeId,
        'support_condition_id': storeStreetLight.supportConditionId,
        'location': storeStreetLight.location,
        'lamp_count': storeStreetLight.lampCount,
        if (storeStreetLight.cabinetId != null) 'cabinet_id': storeStreetLight.cabinetId,
        if (storeStreetLight.meterId != null) 'meter_id': storeStreetLight.meterId,
        'municipality_id': storeStreetLight.municipalityId,
        'lamps': lampsData,
      });

      // Log des données (sauf le fichier)
      _logger.i("FormData: ${{
        ...formData.fields.asMap().map((_, field) => MapEntry(field.key, field.value)),
        'photo': 'File(${photo.path})',
        'lamps': lampsData,
      }}");

      final response = await _dio
          .post(
            url,
            data: formData,
            options: _buildOptions(token),
          )
          .timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<StoreStreetLightResponse>.fromJson(
        response.data,
        (data) => StoreStreetLightResponse.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.e("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.e("Dio error: ${e.message}\nResponse: ${e.response?.data}");
      throw handleDioError(e);
    } catch (e, stacktrace) {
      _logger.e("Unexpected error: $e\nStacktrace: $stacktrace");
      throw BadRequestException(
        message: "Unexpected error occurred: $e",
      );
    } finally {
      stopwatch.stop();
    }
  }

Future<ResponseModel<StoreStreetLightResponse>> updateStreetLight({
  required int streetLightId, // Changé de qrCode vers streetLightId
  required Map<String, dynamic> updateData, // Données à modifier
  XFile? newPhoto, // Photo optionnelle
}) async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}update-streetlight');
  
  final stopwatch = Stopwatch()..start();

  try {
    _logger.i("Starting PUT request to: $url");
    _logger.i("Updating streetlight ID: $streetLightId");

    // Préparation des données de base
    final Map<String, dynamic> formDataMap = {
      'id': streetLightId, // L'API backend attend 'id'
      ...updateData, // Toutes les autres données à modifier
    };

    // Ajouter la photo si fournie
    FormData formData;
    if (newPhoto != null) {
      formDataMap['photo'] = await MultipartFile.fromFile(
        newPhoto.path,
        filename: 'streetlight_update_${streetLightId}_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      _logger.i("Photo included in update: ${newPhoto.path}");
    }

    formData = FormData.fromMap(formDataMap);

    // Log des données (sans la photo pour éviter les logs trop longs)
    final logData = Map<String, dynamic>.from(formDataMap);
    if (newPhoto != null) {
      logData['photo'] = 'File(${newPhoto.path})';
    }
    _logger.i("Update data: $logData");

    final response = await _dio
        .post( // Utiliser POST comme indiqué dans l'API backend
          url,
          data: formData,
          options: _buildOptions(token),
        )
        .timeout(Duration(seconds: _requestTimeoutSeconds));

    _logger.i("PUT request completed in ${stopwatch.elapsedMilliseconds}ms");

    // Vérification du format de réponse
    final responseData = response.data;
    if (responseData is! Map<String, dynamic>) {
      _logger.e("Invalid response format: ${responseData.runtimeType}");
      throw FormatException('Format de réponse invalide', responseData);
    }

    return ResponseModel<StoreStreetLightResponse>.fromJson(
      responseData,
      (data) => StoreStreetLightResponse.fromJson(data as Map<String, dynamic>),
    );
  } on TimeoutException catch (_) {
    _logger.e("Request timeout after ${_requestTimeoutSeconds}s");
    throw TimeoutException("Request took too long");
  } on DioException catch (e) {
    _logger.e("Dio error: ${e.message}\nResponse: ${e.response?.data}");
    throw handleDioError(e);
  } catch (e, stacktrace) {
    _logger.e("Unexpected error during streetlight update: $e\nStacktrace: $stacktrace");
    throw BadRequestException(
      message: "Échec de la mise à jour du lampadaire: $e",
    );
  } finally {
    stopwatch.stop();
  }
}
  String getControllerName() => 'interventions/';
}
