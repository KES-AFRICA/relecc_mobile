part of 'mission_cubit.dart';

@freezed
class MissionState with _$MissionState {
  factory MissionState.initial() = _MissionInitial;

  factory MissionState.loading() = _MissionLoading;

  // États existants
  factory MissionState.success({
    required ResponseModelWithList<Mission> response,
  }) = _MissionSucess;

  factory MissionState.successEquipment({
    required ResponseModel<EquipmentResponse> response,
  }) = _MissionSucessEquipement;

  factory MissionState.successEquipmentMaintenance({
    required ResponseModel<EquipmentMaintenanceResponse> response,
  }) = _MissionSucessEquipementMaintenance;

  // NOUVEAUX ÉTATS POUR NETWORK ANALYSIS
  factory MissionState.successNetworkAnalysis({
    required ResponseModel<NetworkAnalysisResponse> response,
  }) = _MissionSuccessNetworkAnalysis;

  factory MissionState.successNetworkFilterOptions({
    required ResponseModel<NetworkFilterOptionsResponse> response,
  }) = _MissionSuccessNetworkFilterOptions;

  factory MissionState.successNetworkDetails({
    required ResponseModel<Map<String, dynamic>> response,
  }) = _MissionSuccessNetworkDetails;

  factory MissionState.successNetworkQuickStats({
    required ResponseModel<Map<String, dynamic>> response,
  }) = _MissionSuccessNetworkQuickStats;

  factory MissionState.successNetworkExport({
    required ResponseModel<Map<String, dynamic>> response,
  }) = _MissionSuccessNetworkExport;

  // État d'erreur
  factory MissionState.failure({
    required String error,
  }) = _MissionFailed;
}