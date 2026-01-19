// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipmentResponseAdapter extends TypeAdapter<EquipmentResponse> {
  @override
  final int typeId = 3;

  @override
  EquipmentResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EquipmentResponse(
      streetlights: (fields[0] as List?)?.cast<StoreStreetLightResponse>(),
      cabinets: (fields[1] as List?)?.cast<CabinetResponse>(),
      meters: (fields[2] as List?)?.cast<MeterResponse>(),
      substations: (fields[3] as List?)?.cast<dynamic>(),
      meta: fields[4] as EquipmentMeta?,
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.streetlights)
      ..writeByte(1)
      ..write(obj.cabinets)
      ..writeByte(2)
      ..write(obj.meters)
      ..writeByte(3)
      ..write(obj.substations)
      ..writeByte(4)
      ..write(obj.meta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EquipmentMetaAdapter extends TypeAdapter<EquipmentMeta> {
  @override
  final int typeId = 4;

  @override
  EquipmentMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EquipmentMeta(
      currentPage: fields[0] as int?,
      lastPage: fields[1] as int?,
      perPage: fields[2] as int?,
      total: fields[3] as int?,
      totalInterventions: fields[4] as int?,
      totalEquipments: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentMeta obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currentPage)
      ..writeByte(1)
      ..write(obj.lastPage)
      ..writeByte(2)
      ..write(obj.perPage)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.totalInterventions)
      ..writeByte(5)
      ..write(obj.totalEquipments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentResponse _$EquipmentResponseFromJson(Map<String, dynamic> json) =>
    EquipmentResponse(
      streetlights: (json['streetlights'] as List<dynamic>?)
          ?.map((e) =>
              StoreStreetLightResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      cabinets: (json['cabinets'] as List<dynamic>?)
          ?.map((e) => CabinetResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      meters: (json['meters'] as List<dynamic>?)
          ?.map((e) => MeterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      substations: json['Couleurs'] as List<dynamic>?,
      meta: json['meta'] == null
          ? null
          : EquipmentMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipmentResponseToJson(EquipmentResponse instance) =>
    <String, dynamic>{
      'streetlights': instance.streetlights,
      'cabinets': instance.cabinets,
      'meters': instance.meters,
      'Couleurs': instance.substations,
      'meta': instance.meta,
    };

EquipmentMeta _$EquipmentMetaFromJson(Map<String, dynamic> json) =>
    EquipmentMeta(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      totalInterventions: (json['total_interventions'] as num?)?.toInt(),
      totalEquipments: (json['total_equipments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EquipmentMetaToJson(EquipmentMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_interventions': instance.totalInterventions,
      'total_equipments': instance.totalEquipments,
    };
