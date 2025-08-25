import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/controller/repository/intervention_repository.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'intervention_state.dart';
part 'intervention_cubit.freezed.dart';

class InterventionCubit extends Cubit<InterventionState> {
  final InterventionRepository _interventionRepository;

  InterventionCubit({
    PreferencesService? preferencesService,
    InterventionRepository? interventionRepository,
  }) : _interventionRepository = interventionRepository ?? locator<InterventionRepository>(),
        super(InterventionState.initial());

  void getAllStreetLightInformation() async {
    emit(InterventionState.loading());
    try {
      final response = await _interventionRepository.getAllStreetLightInformation();
      emit(InterventionState.success(response: response));
    } catch (error) {
      emit(InterventionState.failure(error: error.toString()));
    }
  }

  void storeStreetLightInformation({
    required XFile photo, 
    required StoreStreetLightInformation storeStreetLight
  }) async {
    emit(InterventionState.loading());
    try {
      final response = await _interventionRepository.createStreetLightInformation(
        photo: photo, 
        storeStreetLight: storeStreetLight
      );
      emit(InterventionState.storeSuccess(response: response));
    } catch (error) {
      emit(InterventionState.failure(error: error.toString()));
    }
  }

  // Méthode mise à jour pour correspondre à la nouvelle signature du repository
  Future<void> updateStreetLight({
    required int streetLightId, // Changé de qrCode vers streetLightId
    required Map<String, dynamic> updateData, // Renommé de data vers updateData pour plus de clarté
    XFile? newPhoto, // Ajout du paramètre photo optionnel
  }) async {
    emit(InterventionState.loading());
    try {
      final response = await _interventionRepository.updateStreetLight(
        streetLightId: streetLightId,
        updateData: updateData,
        newPhoto: newPhoto,
      );
      emit(InterventionState.updateSuccess(response: response));
    } catch (error) {
      emit(InterventionState.failure(error: error.toString()));
    }
  }

  // Méthodes utilitaires pour des cas d'usage spécifiques

  /// Met à jour seulement la photo d'un lampadaire
  Future<void> updateStreetLightPhoto({
    required int streetLightId,
    required XFile newPhoto,
  }) async {
    await updateStreetLight(
      streetLightId: streetLightId,
      updateData: {}, // Aucune autre donnée à modifier
      newPhoto: newPhoto,
    );
  }

  /// Met à jour des propriétés spécifiques sans changer la photo
  Future<void> updateStreetLightProperties({
    required int streetLightId,
    required Map<String, dynamic> properties,
  }) async {
    await updateStreetLight(
      streetLightId: streetLightId,
      updateData: properties,
      // newPhoto reste null
    );
  }

  /// Met à jour le nom du lampadaire uniquement
  Future<void> updateStreetLightName({
    required int streetLightId,
    required String newName,
  }) async {
    await updateStreetLightProperties(
      streetLightId: streetLightId,
      properties: {'name': newName},
    );
  }

  /// Met à jour la localisation du lampadaire uniquement
  Future<void> updateStreetLightLocation({
    required int streetLightId,
    required String newLocation,
  }) async {
    await updateStreetLightProperties(
      streetLightId: streetLightId,
      properties: {'location': newLocation},
    );
  }

  /// Met à jour le nombre de lampes
  Future<void> updateStreetLightLampCount({
    required int streetLightId,
    required int lampCount,
  }) async {
    await updateStreetLightProperties(
      streetLightId: streetLightId,
      properties: {'lamp_count': lampCount},
    );
  }
}