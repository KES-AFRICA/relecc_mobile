import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipement_maintenance.modal.dart';
import 'package:sopaki_app/src/features/equipement/logic/model/equipment.model.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/repository/mission_repository.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/network/logic/model/network_analysis_response.dart';
import 'package:sopaki_app/src/features/network/logic/model/network_filter_options_response.dart';
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

  void getAllEquipmentsMission(
    int missionId, {
    int page = 1,
    int perPage = 10,
    String? equipmentType,
  }) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getAllEquipmentOfMission(
        missionId,
        page: page,
        perPage: perPage,
        equipmentType: equipmentType,
      );
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

  // ============ NOUVELLES MÉTHODES POUR NETWORK ANALYSIS ============

  void analyzeNetworks({
    int page = 1,
    int perPage = 10,
    String? type,
    String? municipality,
  }) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.analyzeNetworks(
        page: page,
        perPage: perPage,
        type: type,
        municipality: municipality,
      );
      // CORRECTION : Maintenant le repository retourne ResponseModel<NetworkAnalysisData>
      // On doit le convertir en ResponseModel<NetworkAnalysisResponse>
      
      // Créer un NetworkAnalysisResponse à partir du NetworkAnalysisData
      final networkData = response.data!;
      final networkResponse = NetworkAnalysisResponse(
        success: true,
        error: false,
        message: 'Réseaux récupérés avec succès',
        data: networkData, // <-- Ici on passe le NetworkAnalysisData directement
      );
      
      // Créer un nouveau ResponseModel
      final correctedResponse = ResponseModel<NetworkAnalysisResponse>(
        success: response.success,
        error: response.error,
        status: response.status,
        message: response.message,
        data: networkResponse,
      );
      
      emit(MissionState.successNetworkAnalysis(response: correctedResponse));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }

  void getNetworkFilterOptions() async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getNetworkFilterOptions();
      emit(MissionState.successNetworkFilterOptions(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }

  void getNetworkDetails({
    required String type,
    required String id,
  }) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getNetworkDetails(
        type: type,
        id: id,
      );
      emit(MissionState.successNetworkDetails(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }

  void getNetworkQuickStats() async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.getNetworkQuickStats();
      emit(MissionState.successNetworkQuickStats(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }

  void exportNetworks({
    String? type,
    String? municipality,
  }) async {
    emit(MissionState.loading());
    try {
      final response = await _missionRepository.exportNetworks(
        type: type,
        municipality: municipality,
      );
      emit(MissionState.successNetworkExport(response: response));
    } catch (error) {
      emit(MissionState.failure(error: error.toString()));
    }
  }

  // ============ MÉTHODES DE RÉINITIALISATION ============

  void resetNetworkAnalysis() {
    emit(MissionState.successNetworkAnalysis(
      response: ResponseModel<NetworkAnalysisResponse>(
        success: true,
        error: false,
        status: 200,
        message: '',
        data: NetworkAnalysisResponse(
          success: true,
          error: false,
          message: '',
          data: NetworkAnalysisData(
            networks: [],
            statistics: NetworkStatistics(
              totalNetworks: 0,
              totalStreetlights: 0,
              totalPowerW: 0,
              totalDistanceKm: 0,
              totalOnDay: 0,
              totalOnNight: 0,
              byType: {},
              byMunicipality: [],
              creationStats: CreationStats(
                newestNetworkDaysAgo: 0,
                oldestNetworkDaysAgo: 0,
                averageNetworkAgeDays: 0,
              ),
            ),
            meta: NetworkMeta(
              currentPage: 1,
              lastPage: 1,
              perPage: 10,
              total: 0,
              totalNetworks: 0,
            ),
          ),
        ),
      ),
    ));
  }

  void resetNetworkFilterOptions() {
    emit(MissionState.successNetworkFilterOptions(
      response: ResponseModel<NetworkFilterOptionsResponse>(
        success: true,
        error: false,
        status: 200,
        message: '',
        data: NetworkFilterOptionsResponse(
          success: true,
          error: false,
          message: '',
          data: FilterOptionsData(
            networkTypes: [],
            municipalities: [],
          ),
        ),
      ),
    ));
  }

  void resetToInitial() {
    emit(MissionState.initial());
  }
}