import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';

part 'street_light.model.g.dart';


@JsonSerializable()
@HiveType(typeId: 4)
class StreetLightInformation extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'TypeLampadaires')
  final List<Common>? typeLampadaires;
  @HiveField(1)
  @JsonKey(name: 'Réseaux')
  final List<Common>? reseaux;
  @HiveField(2)
  @JsonKey(name: 'TypeDeLampe')
  final List<Common>? typeDeLampe;
  @HiveField(3)
  @JsonKey(name: 'Couleurs')
  final List<Common>? couleurs;
  @HiveField(4)
  @JsonKey(name: 'Orientations')
  final List<Common>? orientations;
  @HiveField(5)
  @JsonKey(name: 'Voies')
  final List<Common>? voies;
  @HiveField(6)
  @JsonKey(name: 'Commandes')
  final List<Common>? commandes;
  @HiveField(7)
  @JsonKey(name: 'TypesDeSupport')
  final List<Common>? typesDeSupport;
  @HiveField(8)
  @JsonKey(name: 'ConditionsDeSupport')
  final List<Common>? conditionsDeSupport;
  @HiveField(9)
  @JsonKey(name: 'Municipalites')
  final List<Common>? municipalites;
  @HiveField(10)
  @JsonKey(name: 'streets')
  final List<Common>? streets;

  StreetLightInformation(
      {this.typeLampadaires,
      this.reseaux,
      this.typeDeLampe,
      this.couleurs,
      this.orientations,
      this.voies,
      this.commandes,
      this.typesDeSupport,
      this.conditionsDeSupport,
      this.municipalites,
      this.streets});

  factory StreetLightInformation.fromJson(Map<String, dynamic> json) => _$StreetLightInformationFromJson(json);

  Map<String, dynamic> toJson() => _$StreetLightInformationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 5)
class StoreStreetLightInformation extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'qrcode')
  final String? qrcode;
  @HiveField(1)
  @JsonKey(name: 'streetlight_type_id')
  final int streetlighttypeId;
  @HiveField(2)
  @JsonKey(name: 'network_id')
  final int networkId;
  @HiveField(3)
  @JsonKey(name: 'orientation_id')
  final int orientationId;
  @HiveField(4)
  @JsonKey(name: 'track_id')
  final int trackId;
  @HiveField(5)
  @JsonKey(name: 'command_type_id')
  final int commandTypeId;
  @HiveField(6)
  @JsonKey(name: 'support_type_id')
  final int supportTypeId;
  @HiveField(7)
  @JsonKey(name: 'support_condition_id')
  final int supportConditionId;
  @HiveField(8)
  @JsonKey(name: 'location')
  final String location;
  @HiveField(9)
  @JsonKey(name: 'street')
  final String street;
  @HiveField(10)
  @JsonKey(name: 'lamp_count')
  final int lampCount;
  @HiveField(11)
  @JsonKey(name: 'cabinet_id')
  final int? cabinetId;
  @HiveField(12)
  @JsonKey(name: 'meter_id')
  final int? meterId;
  @HiveField(13)
  @JsonKey(name: 'municipality_id')
  final int municipalityId;
  @HiveField(14)
  @JsonKey(name: 'lamps')
  final List<StoreStreetLampInformation>? lamps;

  StoreStreetLightInformation(
      {this.qrcode,
        this.meterId,
        required this.street,
      required this.streetlighttypeId,
      required this.networkId,
      required this.orientationId,
      required this.trackId,
      required this.commandTypeId,
      required this.supportTypeId,
      required this.supportConditionId,
      required this.location,
      required this.lampCount,
        this.cabinetId,
      required this.municipalityId,
      required this.lamps});

  factory StoreStreetLightInformation.fromJson(Map<String, dynamic> json) =>
      _$StoreStreetLightInformationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStreetLightInformationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 6)
class StoreStreetLampInformation extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'lamp_type_id')
  final int? lampTypeId;
  @HiveField(1)
  @JsonKey(name: 'power')
  final int? power;
  @HiveField(2)
  @JsonKey(name: 'color_id')
  final int? colorId;
  @HiveField(3)
  @JsonKey(name: 'has_lamp')
  final int? hasLamp;
  @HiveField(4)
  @JsonKey(name: 'with_balast')
  final int? withbalast;
  @HiveField(5)
  @JsonKey(name: 'is_on_day')
  final int? isOnDay;
  @HiveField(6)
  @JsonKey(name: 'is_on_night')
  final int? isOnNight;
  @HiveField(7)
  @JsonKey(name: 'lamp_type')
  final String? lamp_type;
  @HiveField(8)
  @JsonKey(name: 'lamp_color')
  final String? lamp_color;

  StoreStreetLampInformation({
    this.lampTypeId,
    this.power,
    this.colorId,
    this.hasLamp,
    this.withbalast,
    this.isOnDay,
    this.isOnNight,
    this.lamp_type,
    this.lamp_color,
  });

  factory StoreStreetLampInformation.fromJson(Map<String, dynamic> json) => _$StoreStreetLampInformationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStreetLampInformationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 7)
class StoreStreetLightResponse extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'id')
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'name')
  final String? name;
  @HiveField(2)
  @JsonKey(name: 'power')
  final int? power;
  @HiveField(3)
  @JsonKey(name: 'is_on_day')
  final int? isOnDay;
  @HiveField(4)
  @JsonKey(name: 'is_on_night')
  final int? isOnNight;
  @HiveField(5)
  @JsonKey(name: 'photo')
  final String? photo;
  @HiveField(6)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(7)
  @JsonKey(name: 'lamp_count')
  final int? lampCount;
  @HiveField(8)
  @JsonKey(name: 'streetlight_type_id')
  final int? streetLightTypeId;
  @HiveField(9)
  @JsonKey(name: 'qrcode_id')
  final int? qrcodeId;
  @HiveField(10)
  @JsonKey(name: 'network_id')
  final int? networkId;
  @HiveField(11)
  @JsonKey(name: 'orientation_id')
  final int? orientationId;
  @HiveField(12)
  @JsonKey(name: 'track_id')
  final int? trackId;
  @HiveField(13)
  @JsonKey(name: 'command_type_id')
  final int? commandTypeId;
  @HiveField(14)
  @JsonKey(name: 'support_type_id')
  final int? supportTypeId;
  @HiveField(15)
  @JsonKey(name: 'support_condition_id')
  final int? supportConditionId;
  @HiveField(16)
  @JsonKey(name: 'street_id')
  final int? streetId;
  @HiveField(17)
  @JsonKey(name: 'meter_id')
  final int? meterId;
  @HiveField(18)
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @HiveField(19)
  @JsonKey(name: 'cabinet_id')
  final int? cabinetId;
  @HiveField(20)
  @JsonKey(name: 'streetlight_type')
  final Common? streetLightType;
  @HiveField(21)
  final Common? network;
  @HiveField(22)
  final Common? orientation;
  @HiveField(23)
  final Common? track;
  @JsonKey(name: 'command_type')
  final Common? commandType;
  @HiveField(24)
  @JsonKey(name: 'support_type')
  final Common? supportType;
  @HiveField(25)
  @JsonKey(name: 'support_condition')
  final Common? supportCondition;
  @HiveField(26)
  final Common? street;
  @HiveField(27)
  final Common? municipality;
  @HiveField(28)
  final CabinetResponse? cabinet;
  @HiveField(29)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @HiveField(30)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

    @HiveField(31)
  @JsonKey(name: 'lamps')
  final List<StoreStreetLampInformation>? lamps;

      @HiveField(32)
  @JsonKey(name: 'report')
  final String? report;


  StoreStreetLightResponse(
      {this.id,
      this.name,
      this.power,
      this.isOnDay,
      this.isOnNight,
      this.photo,
      this.location,
      this.lampCount,
      this.streetLightTypeId,
      this.qrcodeId,
      this.networkId,
      this.orientationId,
      this.trackId,
      this.commandTypeId,
      this.supportTypeId,
      this.supportConditionId,
      this.streetId,
      this.meterId,
      this.municipalityId,
      this.cabinetId,
      this.streetLightType,
      this.network,
      this.orientation,
      this.track,
      this.commandType,
      this.supportType,
      this.supportCondition,
      this.street,
      this.municipality,
      this.cabinet,
      this.createdAt,  // Nouveau champ
      this.updatedAt,  // Nouveau champ
      this.lamps,  // Nouveau champ
      this.report
      });

  factory StoreStreetLightResponse.fromJson(Map<String, dynamic> json) => _$StoreStreetLightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStreetLightResponseToJson(this);
}


@JsonSerializable()
@HiveType(typeId: 8)
class StoreStreetLightResponseComplet extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'id')
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'name')
  final String? name;
  @HiveField(2)
  @JsonKey(name: 'power')
  final int? power;
  @HiveField(3)
  @JsonKey(name: 'is_on_day')
  final int? isOnDay;
  @HiveField(4)
  @JsonKey(name: 'is_on_night')
  final int? isOnNight;
  @HiveField(5)
  @JsonKey(name: 'photo')
  final String? photo;
  @HiveField(6)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(7)
  @JsonKey(name: 'lamp_count')
  final int? lampCount;
  @HiveField(8)
  @JsonKey(name: 'streetlight_type_id')
  final int? streetLightTypeId;
  @HiveField(9)
  @JsonKey(name: 'qrcode_id')
  final int? qrcodeId;
  @HiveField(10)
  @JsonKey(name: 'network_id')
  final int? networkId;
  @HiveField(11)
  @JsonKey(name: 'orientation_id')
  final int? orientationId;
  @HiveField(12)
  @JsonKey(name: 'track_id')
  final int? trackId;
  @HiveField(13)
  @JsonKey(name: 'command_type_id')
  final int? commandTypeId;
  @HiveField(14)
  @JsonKey(name: 'support_type_id')
  final int? supportTypeId;
  @HiveField(15)
  @JsonKey(name: 'support_condition_id')
  final int? supportConditionId;
  @HiveField(16)
  @JsonKey(name: 'street_id')
  final int? streetId;
  @HiveField(17)
  @JsonKey(name: 'meter_id')
  final int? meterId;
  @HiveField(18)
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @HiveField(19)
  @JsonKey(name: 'cabinet_id')
  final int? cabinetId;
  @HiveField(20)
  @JsonKey(name: 'streetlight_type')
  final String? streetLightType;
  @HiveField(21)
  final String? network;
  @HiveField(22)
  final String? orientation;
  @HiveField(23)
  final String? track;
  @JsonKey(name: 'command_type')
  final String? commandType;
  @HiveField(24)
  @JsonKey(name: 'support_type')
  final String? supportType;
  @HiveField(25)
  @JsonKey(name: 'support_condition')
  final String? supportCondition;
  @HiveField(26)
  final String? street;
  @HiveField(27)
  final String? municipality;
  @HiveField(28)
  final CabinetResponse? cabinet;
  @HiveField(29)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @HiveField(30)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

    @HiveField(31)
  @JsonKey(name: 'lamps')
  final List<StoreStreetLampInformation>? lamps;

      @HiveField(32)
  @JsonKey(name: 'report')
  final String? report;


  StoreStreetLightResponseComplet(
      {this.id,
      this.name,
      this.power,
      this.isOnDay,
      this.isOnNight,
      this.photo,
      this.location,
      this.lampCount,
      this.streetLightTypeId,
      this.qrcodeId,
      this.networkId,
      this.orientationId,
      this.trackId,
      this.commandTypeId,
      this.supportTypeId,
      this.supportConditionId,
      this.streetId,
      this.meterId,
      this.municipalityId,
      this.cabinetId,
      this.streetLightType,
      this.network,
      this.orientation,
      this.track,
      this.commandType,
      this.supportType,
      this.supportCondition,
      this.street,
      this.municipality,
      this.cabinet,
      this.createdAt,  // Nouveau champ
      this.updatedAt,  // Nouveau champ
      this.lamps,  // Nouveau champ
      this.report
      });

  factory StoreStreetLightResponseComplet.fromJson(Map<String, dynamic> json) => _$StoreStreetLightResponseCompletFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStreetLightResponseCompletToJson(this);
}
