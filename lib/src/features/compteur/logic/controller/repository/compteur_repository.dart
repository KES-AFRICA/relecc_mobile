import 'dart:async';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
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

class CompteurRepository {
  static const int _requestTimeoutSeconds = 60; // Timeout pour toutes les requêtes
  final Dio _dio;

  CompteurRepository({Dio? dio}) : _dio = dio ?? Dio() {
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

  Future<ResponseModel<Meter>> getAllCompteurInformation() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}create-meter');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<Meter>.fromJson(
        response.data,
            (data) => Meter.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.f("Dio error: ${e.message}");
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

  Future<ResponseModel<MeterResponseData>> createMeterInformation({
    required XFile photo,
    required StoreMeterInformation storeMeter,
  }) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}store-meter');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting POST request to: $url");

      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: 'meter_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'qrcode': storeMeter.qrcode,
        'number': storeMeter.number,
        'model': storeMeter.model,
        'brand': storeMeter.brand,
        'location': storeMeter.location,
        'street': storeMeter.street,
        'municipality_id': storeMeter.municipalityId,
      });

      // Log des données (sauf le fichier)
      _logger.i("FormData: ${{
        ...formData.fields.asMap().map((_, field) => MapEntry(field.key, field.value)),
        'photo': 'File(${photo.path})'
      }}");

      final response = await _dio.post(
        url,
        data: formData,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<MeterResponseData>.fromJson(
        response.data,
            (data) => MeterResponseData.fromJson(data as Map<String, dynamic>),
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

  String getControllerName() => 'interventions/';
}