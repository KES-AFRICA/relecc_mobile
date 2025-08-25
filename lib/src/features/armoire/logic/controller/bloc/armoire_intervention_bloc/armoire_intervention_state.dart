part of 'armoire_intervention_cubit.dart';

@freezed
class ArmoireInterventionState with _$ArmoireInterventionState {
  factory ArmoireInterventionState.initial() = _ArmoireInterventionStateInitial;

  factory ArmoireInterventionState.loading() = _ArmoireInterventionStateLoading;

  factory ArmoireInterventionState.success({required ResponseModel<Cabinet> response}) = _ArmoireInterventionStateSucess;

  factory ArmoireInterventionState.storeSuccess({required ResponseModel<CabinetResponseData> response}) = _ArmoireInterventionStateStoreSucess;

  factory ArmoireInterventionState.failure({required String error}) = _ArmoireInterventionStateFailed;
}
