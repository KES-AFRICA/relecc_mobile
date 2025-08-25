part of 'intervention_cubit.dart';


@freezed
class InterventionState with _$InterventionState {
  factory InterventionState.initial() = _InterventionStateInitial;

  factory InterventionState.loading() = _InterventionStateLoading;

  factory InterventionState.success({required ResponseModel<StreetLightInformation> response}) = _InterventionStateSucess;

  factory InterventionState.storeSuccess({required ResponseModel<dynamic> response}) = _InterventionStateStoreSucess;

  factory InterventionState.updateSuccess({required ResponseModel<dynamic> response}) = _UpdateSuccess; // Nouveau state

  factory InterventionState.failure({required String error}) = _InterventionStateFailed;
}
