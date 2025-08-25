// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CabinetAdapter extends TypeAdapter<Cabinet> {
  @override
  final int typeId = 13;

  @override
  Cabinet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cabinet(
      municipalities: (fields[0] as List?)?.cast<Common>(),
      streets: (fields[1] as List?)?.cast<Common>(),
      cabinetData: fields[2] as CabinetResponse?,
    );
  }

  @override
  void write(BinaryWriter writer, Cabinet obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.municipalities)
      ..writeByte(1)
      ..write(obj.streets)
      ..writeByte(2)
      ..write(obj.cabinetData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CabinetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreCabinetInformationAdapter
    extends TypeAdapter<StoreCabinetInformation> {
  @override
  final int typeId = 14;

  @override
  StoreCabinetInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreCabinetInformation(
      street: fields[3] as String?,
      meterId: fields[5] as int?,
      qrcode: fields[0] as String?,
      isPresent: fields[1] as int?,
      location: fields[2] as String?,
      municipalityId: fields[4] as int?,
      lampCount: fields[6] as int?,
      isFunctional: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreCabinetInformation obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.qrcode)
      ..writeByte(1)
      ..write(obj.isPresent)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.street)
      ..writeByte(4)
      ..write(obj.municipalityId)
      ..writeByte(5)
      ..write(obj.meterId)
      ..writeByte(6)
      ..write(obj.lampCount)
      ..writeByte(7)
      ..write(obj.isFunctional);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreCabinetInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CabinetResponseAdapter extends TypeAdapter<CabinetResponse> {
  @override
  final int typeId = 15;

  @override
  CabinetResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CabinetResponse(
      id: fields[0] as int?,
      qrcodeId: fields[1] as int?,
      name: fields[2] as String?,
      photo: fields[3] as String?,
      isFunctional: fields[4] as dynamic,
      lampCount: fields[5] as dynamic,
      location: fields[6] as String?,
      streetId: fields[7] as int?,
      meterId: fields[8] as dynamic,
      substationId: fields[9] as int?,
      municipalityId: fields[10] as dynamic,
      street: fields[11] as Common?,
      municipality: fields[12] as Common?,
      meter: fields[13] as MeterResponse?,
      createdAt: fields[14] as DateTime?,
      updatedAt: fields[15] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CabinetResponse obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.qrcodeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.isFunctional)
      ..writeByte(5)
      ..write(obj.lampCount)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.streetId)
      ..writeByte(8)
      ..write(obj.meterId)
      ..writeByte(9)
      ..write(obj.substationId)
      ..writeByte(10)
      ..write(obj.municipalityId)
      ..writeByte(11)
      ..write(obj.street)
      ..writeByte(12)
      ..write(obj.municipality)
      ..writeByte(13)
      ..write(obj.meter)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CabinetResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cabinet _$CabinetFromJson(Map<String, dynamic> json) => Cabinet(
      municipalities: (json['municipalities'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      streets: (json['streets'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      cabinetData: json['cabinet'] == null
          ? null
          : CabinetResponse.fromJson(json['cabinet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CabinetToJson(Cabinet instance) => <String, dynamic>{
      'municipalities': instance.municipalities,
      'streets': instance.streets,
      'cabinet': instance.cabinetData,
    };

StoreCabinetInformation _$StoreCabinetInformationFromJson(
        Map<String, dynamic> json) =>
    StoreCabinetInformation(
      street: json['street'] as String?,
      meterId: (json['meter_id'] as num?)?.toInt(),
      qrcode: json['qrcode'] as String?,
      isPresent: (json['is_present'] as num?)?.toInt(),
      location: json['location'] as String?,
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      lampCount: (json['lamp_count'] as num?)?.toInt(),
      isFunctional: (json['is_functional'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoreCabinetInformationToJson(
        StoreCabinetInformation instance) =>
    <String, dynamic>{
      'qrcode': instance.qrcode,
      'is_present': instance.isPresent,
      'location': instance.location,
      'street': instance.street,
      'municipality_id': instance.municipalityId,
      'meter_id': instance.meterId,
      'lamp_count': instance.lampCount,
      'is_functional': instance.isFunctional,
    };

CabinetResponse _$CabinetResponseFromJson(Map<String, dynamic> json) =>
    CabinetResponse(
      id: (json['id'] as num?)?.toInt(),
      qrcodeId: (json['qrcode_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      isFunctional: json['is_functional'],
      lampCount: json['lamp_count'],
      location: json['location'] as String?,
      streetId: (json['street_id'] as num?)?.toInt(),
      meterId: json['meter_id'],
      substationId: (json['substation_id'] as num?)?.toInt(),
      municipalityId: json['municipality_id'],
      street: json['street'] == null
          ? null
          : Common.fromJson(json['street'] as Map<String, dynamic>),
      municipality: json['municipality'] == null
          ? null
          : Common.fromJson(json['municipality'] as Map<String, dynamic>),
      meter: json['meter'] == null
          ? null
          : MeterResponse.fromJson(json['meter'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CabinetResponseToJson(CabinetResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrcode_id': instance.qrcodeId,
      'name': instance.name,
      'photo': instance.photo,
      'is_functional': instance.isFunctional,
      'lamp_count': instance.lampCount,
      'location': instance.location,
      'street_id': instance.streetId,
      'meter_id': instance.meterId,
      'substation_id': instance.substationId,
      'municipality_id': instance.municipalityId,
      'street': instance.street,
      'municipality': instance.municipality,
      'meter': instance.meter,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

CabinetResponseData _$CabinetResponseDataFromJson(Map<String, dynamic> json) =>
    CabinetResponseData(
      cabinet: json['cabinet'] == null
          ? null
          : CabinetResponse.fromJson(json['cabinet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CabinetResponseDataToJson(
        CabinetResponseData instance) =>
    <String, dynamic>{
      'cabinet': instance.cabinet,
    };
