import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sopaki_app/src/features/login/logic/model/login.model.dart';
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

class AuthRepository {
  static const int _requestTimeoutSeconds = 30; // Timeout pour toutes les requêtes
  final Dio _dio;

  AuthRepository({Dio? dio}) : _dio = dio ?? Dio() {
    // Configuration globale de Dio
    _dio.options
      ..connectTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..receiveTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..sendTimeout = Duration(seconds: _requestTimeoutSeconds);
  }

  Future<ResponseModel<LoginResponse>> loginUserApp({required Login request}) async {
    final preferencesService = locator<PreferencesService>();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}login');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting POST request to: $url");

      final response = await _dio.post(
        url,
        data: request.toJson(),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      ).timeout(const Duration(seconds: _requestTimeoutSeconds));

      _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");

      final responseData = ResponseModel<LoginResponse>.fromJson(
        response.data,
            (data) => LoginResponse.fromJson(data as Map<String, dynamic>),
      );

      if (responseData.data?.token != null && responseData.data?.user?.id != null) {
        await preferencesService.setLoginAccessToken(responseData.data!.token);
        await preferencesService.setLoginUserId(responseData.data!.user!.id);
        await preferencesService.setUserName(responseData.data!.user!.name);
        await preferencesService.setUserRole(responseData.data!.user!.roles!.first.name);
        await preferencesService.setUserCompany(responseData.data!.user!.company!.name);
        await preferencesService.setUserEmail(responseData.data!.user!.email);
        await preferencesService.setUserTelephone(responseData.data!.user!.phone!);
      } else {
        _logger.w("Missing token or user ID in login response");
        throw BadRequestException(message: "Invalid login response: missing token or user ID");
      }

      return responseData;
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

  String getControllerName() => '';
}