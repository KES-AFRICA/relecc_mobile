import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';

part 'equipement_vue_parc.modal.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class EquipmentVueParcResponse extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'streetlight')
  final List<StoreStreetLightResponseComplet>? streetlight;
  @HiveField(1)
  @JsonKey(name: 'cabinet')
  final List<CabinetResponse>? cabinet;
  @HiveField(2)
  @JsonKey(name: 'meter')
  final List<MeterResponse>? meter;
  @HiveField(3)
  @JsonKey(name: 'Couleur')
  final List<dynamic>? substation;

  EquipmentVueParcResponse({this.streetlight, this.cabinet, this.meter, this.substation});

  factory EquipmentVueParcResponse.fromJson(Map<String, dynamic> json) => _$EquipmentVueParcResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentVueParcResponseToJson(this);
}
