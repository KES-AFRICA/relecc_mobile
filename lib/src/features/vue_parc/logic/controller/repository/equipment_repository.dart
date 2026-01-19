import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sopaki_app/src/service/env.dart';
import 'package:sopaki_app/src/service/exceptions.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';
import 'package:logger/logger.dart';

// Models
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';

// Configuration du logger
final _logger = Logger(
  printer: PrettyPrinter(),
);

class EquipmentRepository {
  static const int _requestTimeoutSeconds = 60;
  final Dio _dio;

  EquipmentRepository({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options
      ..connectTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..receiveTimeout = Duration(seconds: _requestTimeoutSeconds)
      ..sendTimeout = Duration(seconds: _requestTimeoutSeconds);
  }

  Future<String?> _getAuthToken() async {
    final preferencesService = locator<PreferencesService>();
    return preferencesService.getLoginAccessToken();
  }

  Options _buildOptions(String? token) {
    return Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
  }

Future<ResponseModel<List<StoreStreetLightResponseComplet>>> getAllStreetlights() async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/equipments/get-all-streetlights-for-map');

  final stopwatch = Stopwatch()..start();

  try {
    _logger.i("Starting GET request to: $url");

    final response = await _dio.get(
      url,
      options: _buildOptions(token),
    );

    _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
    _logger.d("Raw API response: ${response.data}");

    // Utils
    int? _tryParseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      if (value is double) return value.toInt();
      return null;
    }

    // Custom parser
    StoreStreetLightResponseComplet parseStreetLight(dynamic item) {
      if (item is String) {
        try {
          item = jsonDecode(item);
        } catch (e) {
          _logger.e("Failed to decode item: $item");
          throw FormatException("Invalid JSON string");
        }
      }

      if (item is! Map<String, dynamic>) {
        throw FormatException("Expected a JSON object, got ${item.runtimeType}");
      }

      return StoreStreetLightResponseComplet(
        id: _tryParseInt(item['id']),
        name: item['name']?.toString(),
        power: _tryParseInt(item['power']),
        isOnDay: _tryParseInt(item['is_on_day']),
        isOnNight: _tryParseInt(item['is_on_night']),
        photo: item['photo']?.toString(),
        location: item['location']?.toString(),
        lampCount: _tryParseInt(item['lamp_count']),
        streetLightTypeId: _tryParseInt(item['streetlight_type_id']),
        qrcodeId: _tryParseInt(item['qrcode_id']),
        networkId: _tryParseInt(item['network_id']),
        orientationId: _tryParseInt(item['orientation_id']),
        trackId: _tryParseInt(item['track_id']),
        commandTypeId: _tryParseInt(item['command_type_id']),
        supportTypeId: _tryParseInt(item['support_type_id']),
        supportConditionId: _tryParseInt(item['support_condition_id']),
        streetId: _tryParseInt(item['street_id']),
        meterId: _tryParseInt(item['meter_id']),
        municipalityId: _tryParseInt(item['municipality_id']),
        cabinetId: _tryParseInt(item['cabinet_id']),
        streetLightType: item['streetlight_type'],
        network: item['network'],
        orientation: item['orientation'],
        track: item['track'],
        commandType: item['command_type'],
        supportType: item['support_type'],
        supportCondition: item['support_condition'],
        street: item['street'],
        municipality: item['municipality'],
        cabinet: item['cabinet'] is Map ? CabinetResponse.fromJson(item['cabinet']) : null,
        createdAt: item['created_at'] != null ? DateTime.tryParse(item['created_at'].toString()) : null,
        updatedAt: item['updated_at'] != null ? DateTime.tryParse(item['updated_at'].toString()) : null,
       lamps: item['lamps'] is List
      ? (item['lamps'] as List)
          .map((e) => StoreStreetLampInformation.fromJson(e))
          .toList()
      : null,
      );
    }

    // Analyse du format de la réponse
    final raw = response.data;
    List<dynamic> rawList;

    if (raw is Map && raw['data'] is List) {
      rawList = raw['data'];
    } else if (raw is Map && raw['data'] is Map) {
      rawList = [raw['data']];
    } else if (raw is List) {
      rawList = raw;
    } else {
      _logger.e("Unsupported response format: ${raw.runtimeType}");
      throw FormatException("Unsupported response format");
    }

    final parsed = rawList.map(parseStreetLight).toList();

    return ResponseModel<List<StoreStreetLightResponseComplet>>(
      success: true,
      data: parsed,
      error: false,
      message: '',
      status: 200,
    );
  } on DioException catch (e) {
    _logger.e("Dio error: ${e.message}");
    throw handleDioError(e);
  } catch (e, stacktrace) {
    _logger.e("Unexpected error: $e\nStacktrace: $stacktrace");
    throw BadRequestException(message: "Unexpected error: $e");
  } finally {
    stopwatch.stop();
  }
}

Future<ResponseModel<List<MeterResponse>>> getAllMeters() async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/equipments/get-all-meters-for-map');

  final stopwatch = Stopwatch()..start();

  try {
    _logger.i("Starting GET request to: $url");

    final response = await _dio.get(
      url,
      options: _buildOptions(token),
    ).timeout(Duration(seconds: _requestTimeoutSeconds));

    _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
    _logger.d("Response data type: ${response.data.runtimeType}");
    _logger.d('Raw response data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      final data = response.data['data'];
      if (data is List) {
        final meters = data
            .map((item) => MeterResponse.fromJson(item as Map<String, dynamic>))
            .toList();

        return ResponseModel<List<MeterResponse>>(
          success: response.data['success'] ?? true,
          data: meters,
          error: false,
          status: 200,
          message: '',
        );
      } else {
        throw FormatException("Field 'data' is not a List");
      }
    } else {
      throw FormatException("Unexpected response format");
    }
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
Future<ResponseModel<List<CabinetResponse>>> getAllCabinets() async {
  final token = await _getAuthToken();
  final url = Uri.encodeFull('$API_ENDPOINT/equipments/get-all-cabinets-for-map');

  final stopwatch = Stopwatch()..start();

  try {
    _logger.i("Starting GET request to: $url");

    final response = await _dio.get(
      url,
      options: _buildOptions(token),
    ).timeout(Duration(seconds: _requestTimeoutSeconds));

    _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");
    _logger.d("Response data type: ${response.data.runtimeType}");
    _logger.d('Raw response data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      final data = response.data['data'];
      if (data is List) {
        final cabinets = data
            .map((item) => CabinetResponse.fromJson(item as Map<String, dynamic>))
            .toList();

        return ResponseModel<List<CabinetResponse>>(
          success: response.data['success'] ?? true,
          data: cabinets,
          error: false,
          status: 200,
          message: '',
        );
      } else {
        throw FormatException("Field 'data' is not a List");
      }
    } else {
      throw FormatException("Unexpected response format");
    }
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

}