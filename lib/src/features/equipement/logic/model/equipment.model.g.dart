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
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.streetlights)
      ..writeByte(1)
      ..write(obj.cabinets)
      ..writeByte(2)
      ..write(obj.meters)
      ..writeByte(3)
      ..write(obj.substations);
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
    );

Map<String, dynamic> _$EquipmentResponseToJson(EquipmentResponse instance) =>
    <String, dynamic>{
      'streetlights': instance.streetlights,
      'cabinets': instance.cabinets,
      'meters': instance.meters,
      'Couleurs': instance.substations,
    };
