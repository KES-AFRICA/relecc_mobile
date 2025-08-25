import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sopaki_app/src/features/armoire/logic/controller/repository/armoire_repository.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'armoire_intervention_state.dart';
part 'armoire_intervention_cubit.freezed.dart';

class ArmoireInterventionCubit extends Cubit<ArmoireInterventionState> {
  final ArmoireRepository _armoireRepository;

  ArmoireInterventionCubit({
    PreferencesService? preferencesService,
    ArmoireRepository? armoireRepository,
  })  : _armoireRepository = armoireRepository ?? locator<ArmoireRepository>(),
        super(ArmoireInterventionState.initial());

  void getAllCabinetInformation() async {
    emit(ArmoireInterventionState.loading());
    try {
      final response = await _armoireRepository.getAllCabinetInformation();
      emit(ArmoireInterventionState.success(response: response));
    } catch (error) {
      emit(ArmoireInterventionState.failure(error: error.toString()));
    }
  }

  void storeCabinetInformation({required XFile photo, required StoreCabinetInformation storeCabinet}) async {
    emit(ArmoireInterventionState.loading());
    try {
      final response = await _armoireRepository.createCabinetInformation(photo: photo, storeCabinet: storeCabinet,);
      emit(ArmoireInterventionState.storeSuccess(response: response));
    } catch (error) {
      emit(ArmoireInterventionState.failure(error: error.toString()));
    }finally{   
      final qrcodeCLean= sanitizeFileName(storeCabinet.qrcode!);           // Clé unique pour Hive
final localKey = 'cabinet_$qrcodeCLean';

  // 1️⃣ Sauvegarder l'image localement
  String? localImagePath;
  try {
    final appDir = await getTemporaryDirectory();
    final folder = Directory('${appDir.path}/cabinets/$localKey');
    await folder.create(recursive: true);

    final localImageFile = File('${folder.path}/photo.jpg');
    await localImageFile.writeAsBytes(await photo.readAsBytes());
    localImagePath = localImageFile.path;

    _logger.i("📷 Image sauvegardée localement à $localImagePath");
  } catch (e) {
    _logger.w("⚠️ Erreur lors du stockage de l'image locale: $e");
  }

    // 2️⃣ Création de l'objet local CabinetResponseData (même si pas d'ID backend)
  final localCabinetResponse = CabinetResponse(
    id: null, // pas encore d'ID
    qrcodeId: null,
    name: null,
    photo: localImagePath, // chemin local vers l'image
    isFunctional: storeCabinet.isFunctional,
    lampCount: storeCabinet.lampCount,
    location: storeCabinet.location,
    streetId: null,
    meterId: storeCabinet.meterId,
    substationId: null,
    municipalityId: storeCabinet.municipalityId,
    street: null,
    municipality: null,
    meter: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final localCabinetResponseData = CabinetResponseData(
    cabinet: localCabinetResponse,
  );

    // 3️⃣ Stockage local dans Hive
  try {
    final box = Hive.box('offline_relec_data');
    await box.put(localKey, localCabinetResponseData);
    _logger.i("📦 Cabinet stocké localement avec la clé: $localKey");
  } catch (e) {
    _logger.w("⚠️ Échec du stockage local dans Hive: $e");
  } 
      
    }
  }
    String sanitizeFileName(String input) {
  // Remplace tous les caractères non valides par "_"
  return input.replaceAll(RegExp(r'[^\w\-]+'), '_');
}
// Configuration du logger
final _logger = Logger(
  printer: PrettyPrinter(),
);

}
