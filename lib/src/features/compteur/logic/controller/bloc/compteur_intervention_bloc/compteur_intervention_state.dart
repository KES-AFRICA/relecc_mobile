part of 'compteur_intervention_cubit.dart';

@freezed
class CompteurInterventionState with _$CompteurInterventionState {
  factory CompteurInterventionState.initial() = _CompteurInterventionStateInitial;

  factory CompteurInterventionState.loading() = _CompteurInterventionStateLoading;

  factory CompteurInterventionState.success({required ResponseModel<Meter> response}) = _CompteurInterventionStateSucess;

  factory CompteurInterventionState.storeSuccess({required ResponseModel<MeterResponseData> response}) = _CompteurInterventionStateStoreSucess;

  factory CompteurInterventionState.failure({required String error}) = _CompteurInterventionStateFailed;
}
