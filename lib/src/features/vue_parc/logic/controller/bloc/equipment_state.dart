
part of 'equipment_cubit.dart';


@freezed
class EquipmentState with _$EquipmentState {
  const factory EquipmentState.initial() = _Initial;
  const factory EquipmentState.loading() = _Loading;
  const factory EquipmentState.loaded({
    required List<StoreStreetLightResponseComplet> streetlights,
    required List<MeterResponse> meters,
    required List<CabinetResponse> cabinets,
  }) = _Loaded;
  const factory EquipmentState.failure({required String error}) = _Failure;
}