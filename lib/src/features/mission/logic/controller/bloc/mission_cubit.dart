import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipement_maintenance.modal.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/repository/mission_repository.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/locator.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/services/preferences_service.dart';

part 'mission_state.dart';
part 'mission_cubit.freezed.dart';

class MissionCubit extends Cubit<MissionState> {
  final MissionRepository _missionRepository;

  MissionCubit({
    PreferencesService? preferencesService,
    MissionRepository? missionRepository,
  })  : _missionRepository = missionRepository ?? locator<MissionRepository>(),
        super(MissionState.initial());

  void getAllMission() async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getAllMission();
      emit(MissionState.success(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }
  void getAllEquipmentsMission(int missionId) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getAllEquipmentOfMission(missionId);
      emit(MissionState.successEquipment(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }
    void getAllEquipmentsMissionMaintenance(int missionId) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getAllEquipmentOfMissionMaintenance(missionId);
      emit(MissionState.successEquipmentMaintenance(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }
}
