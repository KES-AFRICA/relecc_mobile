import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';

import '../repository/equipment_repository.dart';

part 'equipment_state.dart';
part 'equipment_cubit.freezed.dart';
class EquipmentCubit extends Cubit<EquipmentState> {
  final EquipmentRepository _equipmentRepository;

  EquipmentCubit({EquipmentRepository? equipmentRepository})
      : _equipmentRepository = equipmentRepository ?? locator<EquipmentRepository>(),
        super(const EquipmentState.initial());

  Future<void> getAllStreetlights() async {
    emit(const EquipmentState.loading());

    try {
      final response = await _equipmentRepository.getAllStreetlights();
        // Vérifie si l'état actuel est déjà 'loaded' pour récupérer les données existantes
    final previous = state is _Loaded ? state as _Loaded : null;

      emit(EquipmentState.loaded(
        streetlights: response.data ?? [],
        meters: previous?.meters ?? [],
      cabinets: previous?.cabinets ?? [],
      ));
    } catch (error) {
      emit(EquipmentState.failure(error: error.toString()));
    }
  }

  Future<void> getAllMeters() async {
    emit(const EquipmentState.loading());

    try {
      final response = await _equipmentRepository.getAllMeters();
       final previous = state is _Loaded ? state as _Loaded : null;

      emit(EquipmentState.loaded(
        streetlights: previous?.streetlights ?? [],
        meters: response.data ?? [],
        cabinets: previous?.cabinets ?? [],
      ));
    } catch (error) {
      emit(EquipmentState.failure(error: error.toString()));
    }
  }

  Future<void> getAllCabinets() async {
    emit(const EquipmentState.loading());

    try {
      final response = await _equipmentRepository.getAllCabinets();
      final previous = state is _Loaded ? state as _Loaded : null;


      emit(EquipmentState.loaded(
        streetlights: previous?.streetlights ?? [],
        meters: previous?.meters ?? [],
        cabinets: response.data ?? [],
      ));
    } catch (error) {
      emit(EquipmentState.failure(error: error.toString()));
    }
  }



}
