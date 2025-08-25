import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sopaki_app/src/features/profil/logic/model/user_profil.model.dart';
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


class UserRepository {
  static const int _requestTimeoutSeconds = 30; // Timeout pour toutes les requêtes
  final Dio _dio;

  UserRepository({Dio? dio}) : _dio = dio ?? Dio() {
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

  Future<ResponseModel<UserProfil>> getUserData() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}get-user');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<UserProfil>.fromJson(
        response.data,
            (data) => UserProfil.fromJson(data as Map<String, dynamic>),
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


  String getControllerName() => 'users/';
}