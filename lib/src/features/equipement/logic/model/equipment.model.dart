import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';

part 'equipment.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class EquipmentResponse extends HiveObject {
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
  
  @HiveField(4)
  @JsonKey(name: 'meta')
  final EquipmentMeta? meta;

  EquipmentResponse({
    this.streetlights,
    this.cabinets,
    this.meters,
    this.substations,
    this.meta,
  });

  factory EquipmentResponse.fromJson(Map<String, dynamic> json) => _$EquipmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 4)
class EquipmentMeta extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'current_page')
  final int? currentPage;
  
  @HiveField(1)
  @JsonKey(name: 'last_page')
  final int? lastPage;
  
  @HiveField(2)
  @JsonKey(name: 'per_page')
  final int? perPage;
  
  @HiveField(3)
  @JsonKey(name: 'total')
  final int? total;
  
  @HiveField(4)
  @JsonKey(name: 'total_interventions')
  final int? totalInterventions;
  
  @HiveField(5)
  @JsonKey(name: 'total_equipments')
  final int? totalEquipments;

  EquipmentMeta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.totalInterventions,
    this.totalEquipments,
  });

  factory EquipmentMeta.fromJson(Map<String, dynamic> json) => _$EquipmentMetaFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentMetaToJson(this);

  void operator [](String other) {}
}