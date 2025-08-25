import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';

part 'cabinet.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 13)
class Cabinet extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'municipalities')
  final List<Common>? municipalities;
  @HiveField(1)
  @JsonKey(name: 'streets')
  final List<Common>? streets;
  @HiveField(2)
  @JsonKey(name: 'cabinet')
  final CabinetResponse? cabinetData;

  Cabinet({
    this.municipalities,
    this.streets,
    this.cabinetData,
  });

  factory Cabinet.fromJson(Map<String, dynamic> json) => _$CabinetFromJson(json);

  Map<String, dynamic> toJson() => _$CabinetToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 14)
class StoreCabinetInformation  extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'qrcode')
  final String? qrcode;
  @HiveField(1)
  @JsonKey(name: 'is_present')
  final int? isPresent;
  @HiveField(2)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(3)
  @JsonKey(name: 'street')
  final String? street;
  @HiveField(4)
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @HiveField(5)
  @JsonKey(name: 'meter_id')
  final int? meterId;
  @HiveField(6)
  @JsonKey(name: 'lamp_count')
  final int? lampCount;
  @HiveField(7)
  @JsonKey(name: 'is_functional')
  final int? isFunctional;

  StoreCabinetInformation(
      {this.street,
        this.meterId,
      this.qrcode,
      this.isPresent,
      this.location,
      this.municipalityId,
      this.lampCount,
      this.isFunctional});

  factory StoreCabinetInformation.fromJson(Map<String, dynamic> json) => _$StoreCabinetInformationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCabinetInformationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 15)
class CabinetResponse extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'qrcode_id')
  final int? qrcodeId;
  @HiveField(2)
  @JsonKey(name: 'name')
  final String? name;
  @HiveField(3)
  @JsonKey(name: 'photo')
  final String? photo;
  @HiveField(4)
  @JsonKey(name: 'is_functional')
  final dynamic isFunctional;
  @HiveField(5)
  @JsonKey(name: 'lamp_count')
  final dynamic lampCount;
  @HiveField(6)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(7)
  @JsonKey(name: 'street_id')
  final int? streetId;
  @HiveField(8)
  @JsonKey(name: 'meter_id')
  final dynamic meterId;
  @HiveField(9)
  @JsonKey(name: 'substation_id')
  final int? substationId;
  @HiveField(10)
  @JsonKey(name: 'municipality_id')
  final dynamic municipalityId;
  @HiveField(11)
  final Common? street;
  @HiveField(12)
  final Common? municipality;
  @HiveField(13)
  final MeterResponse? meter;
  @HiveField(14)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @HiveField(15)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  CabinetResponse({
    this.id,
    this.qrcodeId,
    this.name,
    this.photo,
    this.isFunctional,
    this.lampCount,
    this.location,
    this.streetId,
    this.meterId,
    this.substationId,
    this.municipalityId,
    this.street,
    this.municipality,
    this.meter,
    this.createdAt,  // Nouveau champ
    this.updatedAt,  // Nouveau champ
  });

  factory CabinetResponse.fromJson(Map<String, dynamic> json) => _$CabinetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CabinetResponseToJson(this);
}


@JsonSerializable()
class CabinetResponseData {
  @JsonKey(name: 'cabinet')
  final CabinetResponse? cabinet;


  CabinetResponseData({this.cabinet});

  factory CabinetResponseData.fromJson(Map<String, dynamic> json) => _$CabinetResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CabinetResponseDataToJson(this);
}
