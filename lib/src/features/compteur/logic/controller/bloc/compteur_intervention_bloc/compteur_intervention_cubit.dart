import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/compteur/logic/controller/repository/compteur_repository.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'compteur_intervention_state.dart';
part 'compteur_intervention_cubit.freezed.dart';

class CompteurInterventionCubit extends Cubit<CompteurInterventionState> {
  final CompteurRepository _compteurRepository;

  CompteurInterventionCubit({
    PreferencesService? preferencesService,
    CompteurRepository? compteurRepository,
  })  : _compteurRepository = compteurRepository ?? locator<CompteurRepository>(),
        super(CompteurInterventionState.initial());

  void getAllMeterInformation() async {
    emit(CompteurInterventionState.loading());
    try {
      final response = await _compteurRepository.getAllCompteurInformation();
      emit(CompteurInterventionState.success(response: response));
    } catch (error) {
      emit(CompteurInterventionState.failure(error: error.toString()));
    }
  }

  void storeMeterInformation({required XFile photo, required StoreMeterInformation storeMeter}) async {
    emit(CompteurInterventionState.loading());
    try {
      final response = await _compteurRepository.createMeterInformation(photo: photo, storeMeter: storeMeter);
      emit(CompteurInterventionState.storeSuccess(response: response));
    } catch (error) {
      emit(CompteurInterventionState.failure(error: error.toString()));
    }
  }
}
