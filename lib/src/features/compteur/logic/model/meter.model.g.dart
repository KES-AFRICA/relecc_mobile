// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeterAdapter extends TypeAdapter<Meter> {
  @override
  final int typeId = 9;

  @override
  Meter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meter(
      municipalities: (fields[0] as List?)?.cast<Common>(),
      meterTypes: (fields[1] as List?)?.cast<Common>(),
      substations: (fields[2] as List?)?.cast<Common>(),
    );
  }

  @override
  void write(BinaryWriter writer, Meter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.municipalities)
      ..writeByte(1)
      ..write(obj.meterTypes)
      ..writeByte(2)
      ..write(obj.substations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreMeterInformationAdapter extends TypeAdapter<StoreMeterInformation> {
  @override
  final int typeId = 10;

  @override
  StoreMeterInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreMeterInformation(
      qrcode: fields[0] as String?,
      number: fields[1] as int?,
      location: fields[2] as String?,
      street: fields[3] as String?,
      municipalityId: fields[4] as int?,
      brand: fields[5] as String?,
      model: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreMeterInformation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.qrcode)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.street)
      ..writeByte(4)
      ..write(obj.municipalityId)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreMeterInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeterActionAdapter extends TypeAdapter<MeterAction> {
  @override
  final int typeId = 11;

  @override
  MeterAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeterAction(
      qrcode: fields[0] as String?,
      number: fields[1] as dynamic,
      location: fields[2] as String?,
      street: fields[3] as String?,
      municipalityId: fields[4] as dynamic,
      brand: fields[5] as String?,
      model: fields[6] as String?,
      photo: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MeterAction obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.qrcode)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.street)
      ..writeByte(4)
      ..write(obj.municipalityId)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.model)
      ..writeByte(7)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeterActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeterResponseAdapter extends TypeAdapter<MeterResponse> {
  @override
  final int typeId = 12;

  @override
  MeterResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeterResponse(
      id: fields[0] as int?,
      qrcodeId: fields[1] as int?,
      number: fields[2] as dynamic,
      brand: fields[3] as String?,
      model: fields[4] as String?,
      location: fields[5] as String?,
      municipalityId: fields[6] as dynamic,
      substationId: fields[7] as int?,
      streetId: fields[8] as int?,
      name: fields[9] as String?,
      photo: fields[10] as String?,
      street: fields[12] as Common?,
      municipality: fields[13] as Common?,
      actions: (fields[11] as List?)?.cast<MeterAction>(),
      createdAt: fields[14] as DateTime?,
      updatedAt: fields[15] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MeterResponse obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.qrcodeId)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.brand)
      ..writeByte(4)
      ..write(obj.model)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.municipalityId)
      ..writeByte(7)
      ..write(obj.substationId)
      ..writeByte(8)
      ..write(obj.streetId)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.actions)
      ..writeByte(12)
      ..write(obj.street)
      ..writeByte(13)
      ..write(obj.municipality)
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
      other is MeterResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meter _$MeterFromJson(Map<String, dynamic> json) => Meter(
      municipalities: (json['municipalities'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      meterTypes: (json['meterTypes'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      substations: (json['substations'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MeterToJson(Meter instance) => <String, dynamic>{
      'municipalities': instance.municipalities,
      'meterTypes': instance.meterTypes,
      'substations': instance.substations,
    };

StoreMeterInformation _$StoreMeterInformationFromJson(
        Map<String, dynamic> json) =>
    StoreMeterInformation(
      qrcode: json['qrcode'] as String?,
      number: (json['number'] as num?)?.toInt(),
      location: json['location'] as String?,
      street: json['street'] as String?,
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      model: json['model'] as String?,
    );

Map<String, dynamic> _$StoreMeterInformationToJson(
        StoreMeterInformation instance) =>
    <String, dynamic>{
      'qrcode': instance.qrcode,
      'number': instance.number,
      'location': instance.location,
      'street': instance.street,
      'municipality_id': instance.municipalityId,
      'brand': instance.brand,
      'model': instance.model,
    };

MeterAction _$MeterActionFromJson(Map<String, dynamic> json) => MeterAction(
      qrcode: json['qrcode'] as String?,
      number: json['number'],
      location: json['location'] as String?,
      street: json['street'] as String?,
      municipalityId: json['municipality_id'],
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$MeterActionToJson(MeterAction instance) =>
    <String, dynamic>{
      'qrcode': instance.qrcode,
      'number': instance.number,
      'location': instance.location,
      'street': instance.street,
      'municipality_id': instance.municipalityId,
      'brand': instance.brand,
      'model': instance.model,
      'photo': instance.photo,
    };

MeterResponse _$MeterResponseFromJson(Map<String, dynamic> json) =>
    MeterResponse(
      id: (json['id'] as num?)?.toInt(),
      qrcodeId: (json['qrcode_id'] as num?)?.toInt(),
      number: json['number'],
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      location: json['location'] as String?,
      municipalityId: json['municipality_id'],
      substationId: (json['substation_id'] as num?)?.toInt(),
      streetId: (json['street_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      street: json['street'] == null
          ? null
          : Common.fromJson(json['street'] as Map<String, dynamic>),
      municipality: json['municipality'] == null
          ? null
          : Common.fromJson(json['municipality'] as Map<String, dynamic>),
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => MeterAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MeterResponseToJson(MeterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrcode_id': instance.qrcodeId,
      'number': instance.number,
      'brand': instance.brand,
      'model': instance.model,
      'location': instance.location,
      'municipality_id': instance.municipalityId,
      'substation_id': instance.substationId,
      'street_id': instance.streetId,
      'name': instance.name,
      'photo': instance.photo,
      'actions': instance.actions,
      'street': instance.street,
      'municipality': instance.municipality,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

MeterResponseData _$MeterResponseDataFromJson(Map<String, dynamic> json) =>
    MeterResponseData(
      meter: json['meter'] == null
          ? null
          : MeterResponse.fromJson(json['meter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeterResponseDataToJson(MeterResponseData instance) =>
    <String, dynamic>{
      'meter': instance.meter,
    };
