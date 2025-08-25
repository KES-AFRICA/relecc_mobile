import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';

part 'meter.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class Meter extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'municipalities')
  final List<Common>? municipalities;
  @HiveField(1)
  @JsonKey(name: 'meterTypes')
  final List<Common>? meterTypes;
  @HiveField(2)
  @JsonKey(name: 'substations')
  final List<Common>? substations;

  Meter({this.municipalities, this.meterTypes, this.substations});

  factory Meter.fromJson(Map<String, dynamic> json) => _$MeterFromJson(json);

  Map<String, dynamic> toJson() => _$MeterToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 10)
class StoreMeterInformation extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'qrcode')
  final String? qrcode;
  @HiveField(1)
  @JsonKey(name: 'number')
  final int? number;
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
  @JsonKey(name: 'brand')
  final String? brand;
  @HiveField(6)
  @JsonKey(name: 'model')
  final String? model;

  StoreMeterInformation({
    this.qrcode,
    this.number,
    this.location,
    this.street,
    this.municipalityId,
    this.brand,
    this.model,
  });

  factory StoreMeterInformation.fromJson(Map<String, dynamic> json) => _$StoreMeterInformationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreMeterInformationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 11)
class MeterAction extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'qrcode')
  final String? qrcode;
  @HiveField(1)
  @JsonKey(name: 'number')
  final dynamic number;
  @HiveField(2)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(3)
  @JsonKey(name: 'street')
  final String? street;
  @HiveField(4)
  @JsonKey(name: 'municipality_id')
  final dynamic municipalityId;
  @HiveField(5)
  @JsonKey(name: 'brand')
  final String? brand;
  @HiveField(6)
  @JsonKey(name: 'model')
  final String? model;
  @HiveField(7)
  @JsonKey(name: 'photo')
  final String? photo;

  MeterAction({
    this.qrcode,
    this.number,
    this.location,
    this.street,
    this.municipalityId,
    this.brand,
    this.model,
    this.photo,
  });

  factory MeterAction.fromJson(Map<String, dynamic> json) => _$MeterActionFromJson(json);

  Map<String, dynamic> toJson() => _$MeterActionToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 12)
class MeterResponse extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'qrcode_id')
  final int? qrcodeId;
  @HiveField(2)
  @JsonKey(name: 'number')
  final dynamic number;
  @HiveField(3)
  @JsonKey(name: 'brand')
  final String? brand;
  @HiveField(4)
  @JsonKey(name: 'model')
  final String? model;
  @HiveField(5)
  @JsonKey(name: 'location')
  final String? location;
  @HiveField(6)
  @JsonKey(name: 'municipality_id')
  final dynamic municipalityId;
  @HiveField(7)
  @JsonKey(name: 'substation_id')
  final int? substationId;
  @HiveField(8)
  @JsonKey(name: 'street_id')
  final int? streetId;
  @HiveField(9)
  @JsonKey(name: 'name')
  final String? name;
  @HiveField(10)
  @JsonKey(name: 'photo')
  final String? photo;
  @HiveField(11)
  @JsonKey(name: 'actions')
  final List<MeterAction>? actions;
  @HiveField(12)
  final Common? street;
  @HiveField(13)
  final Common? municipality;
  @HiveField(14)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @HiveField(15)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  MeterResponse(
      {this.id,
      this.qrcodeId,
      this.number,
      this.brand,
      this.model,
      this.location,
      this.municipalityId,
      this.substationId,
      this.streetId,
      this.name,
      this.photo,
      this.street,
      this.municipality,
      this.actions,
      this.createdAt,  // Nouveau champ
      this.updatedAt,  // Nouveau champ
      });

  factory MeterResponse.fromJson(Map<String, dynamic> json) => _$MeterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeterResponseToJson(this);
}


@JsonSerializable()
class MeterResponseData {
  @JsonKey(name: 'meter')
  final MeterResponse? meter;


  MeterResponseData({this.meter});

  factory MeterResponseData.fromJson(Map<String, dynamic> json) => _$MeterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MeterResponseDataToJson(this);
}
