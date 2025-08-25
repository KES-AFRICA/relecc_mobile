
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
// import 'package:sopaki_app/src/features/mission/logic/controller/repository/mission_repository.dart';
// //import 'package:sopaki_app/src/features/mission/logic/repositories/mission_repository.dart';
// import 'package:sopaki_app/src/service/env.dart';
// import 'package:sopaki_app/src/service/exceptions.dart';
// import 'package:sopaki_app/src/shared/locator.dart';
// import 'package:sopaki_app/src/shared/model/response/response.model.dart';
// import 'package:sopaki_app/src/shared/services/preferences_service.dart';
// import 'dart:async';
// import 'package:logger/logger.dart';

// // Configuration du logger
// final _logger = Logger(
//   printer: PrettyPrinter(),
// );

// class ArmoireRepository {
//   static const int _requestTimeoutSeconds = 30;
//   final Dio _dio;
//   final PreferencesService _preferencesService = locator<PreferencesService>();
//   final MissionRepository _missionRepository = locator<MissionRepository>();

//   // Cache en mémoire
//   List<Cabinet>? _cachedCabinets;
//   DateTime? _lastFetchTime;
//   final Duration _cacheDuration = Duration(minutes: 5);

//   ArmoireRepository({Dio? dio}) : _dio = dio ?? Dio() {
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

//   Future<ResponseModel<List<Cabinet>>> getAllCabinetInformation() async {
//     final token = await _getAuthToken();
//     final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}create-cabinet');

//     // Vérifier le cache
//     final now = DateTime.now();
//     if (_cachedCabinets != null && 
//         _lastFetchTime != null && 
//         now.difference(_lastFetchTime!) < _cacheDuration) {
//       _logger.i("Returning cached cabinets data");
//       return ResponseModel<List<Cabinet>>(
//         success: true,
//         error: false,
//         status: 200,
//         message: "Data loaded from cache",
//         data: _cachedCabinets!,
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

//       final result = ResponseModel<List<Cabinet>>.fromJson(
//         response.data,
//         (data) => (data as List).map((e) => Cabinet.fromJson(e as Map<String, dynamic>)).toList(),
//       );

//       // Mettre à jour le cache
//       _cachedCabinets = result.data;
//       _lastFetchTime = DateTime.now();
      
//       // Sauvegarder dans le stockage local
//       await _preferencesService.setCabinetsCache(response.data.toString());
//       await _preferencesService.setCabinetsCacheTime(_lastFetchTime!.toIso8601String());

//       return result;
//     } on TimeoutException catch (_) {
//       _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      
//       if (_cachedCabinets != null) {
//         _logger.w("Returning cached data due to timeout");
//         return ResponseModel<List<Cabinet>>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to timeout",
//           data: _cachedCabinets!,
//         );
//       }
//       throw TimeoutException("Request took too long");
//     } on DioException catch (e) {
//       _logger.e("Dio error: ${e.message}");
      
//       if (_cachedCabinets != null) {
//         _logger.w("Returning cached data due to API error");
//         return ResponseModel<List<Cabinet>>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to API error: ${e.message}",
//           data: _cachedCabinets!,
//         );
//       }
//       throw handleDioError(e);
//     } catch (e, stacktrace) {
//       _logger.e("Unexpected error: $e\nStacktrace: $stacktrace");
      
//       if (_cachedCabinets != null) {
//         _logger.w("Returning cached data due to unexpected error");
//         return ResponseModel<List<Cabinet>>(
//           success: true,
//           error: false,
//           status: 200,
//           message: "Using cached data due to error: $e",
//           data: _cachedCabinets!,
//         );
//       }
//       throw BadRequestException(
//         message: "Unexpected error occurred: $e",
//       );
//     } finally {
//       stopwatch.stop();
//     }
//   }

//   Future<ResponseModel<CabinetResponseData>> createCabinetInformation({
//     required XFile photo,
//     required StoreCabinetInformation storeCabinet,
//     int? missionId, // Ajout du paramètre missionId optionnel
//   }) async {
//     final token = await _getAuthToken();
//     final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}store-cabinet');

//     final stopwatch = Stopwatch()..start();

//     try {
//       _logger.i("Starting POST request to: $url");

//       final formData = FormData.fromMap({
//         'photo': await MultipartFile.fromFile(
//           photo.path,
//           filename: 'cabinet_${DateTime.now().millisecondsSinceEpoch}.jpg',
//         ),
//         'qrcode': storeCabinet.qrcode,
//         'is_present': storeCabinet.isPresent,
//         'is_functional': storeCabinet.isFunctional,
//         'lamp_count': storeCabinet.lampCount,
//         'location': storeCabinet.location,
//         'street': storeCabinet.street,
//         'municipality_id': storeCabinet.municipalityId,
//         if (storeCabinet.meterId != null) 'meter_id': storeCabinet.meterId,
//       });

//       _logger.i("FormData: ${{
//         ...formData.fields.asMap().map((_, field) => MapEntry(field.key, field.value)),
//         'photo': 'File(${photo.path})'
//       }}");

//       final response = await _dio.post(
//         url,
//         data: formData,
//         options: _buildOptions(token),
//       ).timeout(Duration(seconds: _requestTimeoutSeconds));

//       _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");

//       final result = ResponseModel<CabinetResponseData>.fromJson(
//         response.data,
//         (data) => CabinetResponseData.fromJson(data as Map<String, dynamic>),
//       );

//       // Invalider le cache des armoires
//       _cachedCabinets = null;
//       _lastFetchTime = null;
//       await _preferencesService.clearCabinetsCache();

//       // Si une missionId est fournie, notifier le changement d'équipement
//       if (missionId != null) {
//         await _missionRepository.notifyEquipmentChange(missionId);
//       }

//       return result;
//     } on TimeoutException catch (_) {
//       _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
//       throw TimeoutException("Request took too long");
//     } on DioException catch (e) {
//       _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
//       throw handleDioError(e);
//     } catch (e, stacktrace) {
//       _logger.e("Unexpected error: $e\nStacktrace: $stacktrace");
//       throw BadRequestException(
//         message: "Unexpected error occurred: $e",
//       );
//     } finally {
//       stopwatch.stop();
//     }
//   }

//   // Méthode pour forcer le rafraîchissement du cache
//   Future<void> refreshCache() async {
//     _cachedCabinets = null;
//     _lastFetchTime = null;
//     await _preferencesService.clearCabinetsCache();
//   }

//   String getControllerName() => 'interventions/';
// }


import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/service/env.dart';
import 'package:sopaki_app/src/service/exceptions.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';
import 'dart:async';
import 'package:logger/logger.dart';

// Configuration du logger
final _logger = Logger(
  printer: PrettyPrinter(),
);

class ArmoireRepository {
  static const int _requestTimeoutSeconds = 60; // Timeout pour toutes les requêtes
  final Dio _dio;

  ArmoireRepository({Dio? dio}) : _dio = dio ?? Dio() {
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

  Future<ResponseModel<Cabinet>> getAllCabinetInformation() async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}create-cabinet');

    final stopwatch = Stopwatch()..start();

    try {
      _logger.i("Starting GET request to: $url");

      final response = await _dio.get(
        url,
        options: _buildOptions(token),
      ).timeout(Duration(seconds: _requestTimeoutSeconds));

      _logger.i("GET request completed in ${stopwatch.elapsedMilliseconds}ms");

      return ResponseModel<Cabinet>.fromJson(
        response.data,
            (data) => Cabinet.fromJson(data as Map<String, dynamic>),
      );
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
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

  Future<ResponseModel<CabinetResponseData>> createCabinetInformation({
    required XFile photo,
    required StoreCabinetInformation storeCabinet,
  }) async {
    final token = await _getAuthToken();
    final url = Uri.encodeFull('$API_ENDPOINT/${getControllerName()}store-cabinet');

    final stopwatch = Stopwatch()..start();


    try {
      _logger.i("Starting POST request to: $url");

      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: 'cabinet_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'qrcode': storeCabinet.qrcode,
        'is_present': storeCabinet.isPresent,
        'is_functional': storeCabinet.isFunctional,
        'lamp_count': storeCabinet.lampCount,
        'location': storeCabinet.location,
        'street': storeCabinet.street,
        'municipality_id': storeCabinet.municipalityId,
        if (storeCabinet.meterId != null) 'meter_id': storeCabinet.meterId,
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

      print(response.data);
       _logger.i("POST request completed in ${stopwatch.elapsedMilliseconds}ms");


      return ResponseModel<CabinetResponseData>.fromJson(
        response.data,
            (data) => CabinetResponseData.fromJson(data as Map<String, dynamic>),
      );
//                // Clé unique pour Hive
// final localKey = 'cabinet_${response.data.cabinet?.name}';

//   // 1️⃣ Sauvegarder l'image localement
//   String? localImagePath;
//   try {
//     final appDir = await getTemporaryDirectory();
//     final folder = Directory('${appDir.path}/cabinets/$localKey');
//     await folder.create(recursive: true);

//     final localImageFile = File('${folder.path}/photo.jpg');
//     await localImageFile.writeAsBytes(await photo.readAsBytes());
//     localImagePath = localImageFile.path;

//     _logger.i("📷 Image sauvegardée localement à $localImagePath");
//   } catch (e) {
//     _logger.w("⚠️ Erreur lors du stockage de l'image locale: $e");
//   }

//     // 2️⃣ Création de l'objet local CabinetResponseData (même si pas d'ID backend)
//   final localCabinetResponse = CabinetResponse(
//     id: null, // pas encore d'ID
//     qrcodeId: null,
//     name: null,
//     photo: localImagePath, // chemin local vers l'image
//     isFunctional: storeCabinet.isFunctional,
//     lampCount: storeCabinet.lampCount,
//     location: storeCabinet.location,
//     streetId: null,
//     meterId: storeCabinet.meterId,
//     substationId: null,
//     municipalityId: storeCabinet.municipalityId,
//     street: null,
//     municipality: null,
//     meter: null,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );

//   final localCabinetResponseData = CabinetResponseData(
//     cabinet: localCabinetResponse,
//   );

//     // 3️⃣ Stockage local dans Hive
//   try {
//     final box = Hive.box('offline_relec_data');
//     await box.put(localKey, localCabinetResponseData);
//     _logger.i("📦 Cabinet stocké localement avec la clé: $localKey");
//   } catch (e) {
//     _logger.w("⚠️ Échec du stockage local dans Hive: $e");
//   } 

     
    } on TimeoutException catch (_) {
      _logger.f("Request timeout after ${_requestTimeoutSeconds}s");
      throw TimeoutException("Request took too long");
    } on DioException catch (e) {
      _logger.f("Dio error: ${e.message}\nResponse: ${e.response?.data}");
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

  String getControllerName() => 'interventions/';
  String sanitizeFileName(String input) {
  // Remplace tous les caractères non valides par "_"
  return input.replaceAll(RegExp(r'[^\w\-]+'), '_');
}

}