part of 'mission_cubit.dart';

@freezed
class MissionState with _$MissionState {
  factory MissionState.initial() = _MissionInitial;

  factory MissionState.loading() = _MissionLoading;

  factory MissionState.success({required ResponseModelWithList<Mission> response}) = _MissionSucess;

  factory MissionState.successEquipment({required ResponseModel<EquipmentResponse> response}) = _MissionSucessEquipement;

  factory MissionState.successEquipmentMaintenance({required ResponseModel<EquipmentMaintenanceResponse> response}) = _MissionSucessEquipementMaintenance;

  factory MissionState.failure({required String error}) = _MissionFailed;
}
