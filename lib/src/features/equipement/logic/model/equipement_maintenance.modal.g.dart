// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipement_maintenance.modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipmentMaintenanceResponseAdapter
    extends TypeAdapter<EquipmentMaintenanceResponse> {
  @override
  final int typeId = 3;

  @override
  EquipmentMaintenanceResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EquipmentMaintenanceResponse(
      streetlight: (fields[0] as List?)?.cast<StoreStreetLightResponse>(),
      cabinet: (fields[1] as List?)?.cast<CabinetResponse>(),
      meter: (fields[2] as List?)?.cast<MeterResponse>(),
      substation: (fields[3] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentMaintenanceResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.streetlight)
      ..writeByte(1)
      ..write(obj.cabinet)
      ..writeByte(2)
      ..write(obj.meter)
      ..writeByte(3)
      ..write(obj.substation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentMaintenanceResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentMaintenanceResponse _$EquipmentMaintenanceResponseFromJson(
        Map<String, dynamic> json) =>
    EquipmentMaintenanceResponse(
      streetlight: (json['streetlight'] as List<dynamic>?)
          ?.map((e) =>
              StoreStreetLightResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      cabinet: (json['cabinet'] as List<dynamic>?)
          ?.map((e) => CabinetResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      meter: (json['meter'] as List<dynamic>?)
          ?.map((e) => MeterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      substation: json['Couleur'] as List<dynamic>?,
    );

Map<String, dynamic> _$EquipmentMaintenanceResponseToJson(
        EquipmentMaintenanceResponse instance) =>
    <String, dynamic>{
      'streetlight': instance.streetlight,
      'cabinet': instance.cabinet,
      'meter': instance.meter,
      'Couleur': instance.substation,
    };
