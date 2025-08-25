import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';

part 'equipment.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class EquipmentResponse extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'streetlights')
  final List<StoreStreetLightResponse>? streetlights;
  @HiveField(1)
  @JsonKey(name: 'cabinets')
  final List<CabinetResponse>? cabinets;
  @HiveField(2)
  @JsonKey(name: 'meters')
  final List<MeterResponse>? meters;
  @HiveField(3)
  @JsonKey(name: 'Couleurs')
  final List<dynamic>? substations;

  EquipmentResponse({this.streetlights, this.cabinets, this.meters, this.substations});

  factory EquipmentResponse.fromJson(Map<String, dynamic> json) => _$EquipmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentResponseToJson(this);
}
