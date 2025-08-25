// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PivotAdapter extends TypeAdapter<Pivot> {
  @override
  final int typeId = 21;

  @override
  Pivot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pivot(
      missionId: fields[0] as int?,
      streetId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Pivot obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.missionId)
      ..writeByte(1)
      ..write(obj.streetId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PivotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      missionId: (json['mission_id'] as num?)?.toInt(),
      streetId: (json['street_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'mission_id': instance.missionId,
      'street_id': instance.streetId,
    };
