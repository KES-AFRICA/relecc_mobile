// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neighborhood.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NeighborhoodAdapter extends TypeAdapter<Neighborhood> {
  @override
  final int typeId = 20;

  @override
  Neighborhood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Neighborhood(
      id: fields[0] as int?,
      name: fields[1] as String?,
      municipalityId: fields[2] as int?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Neighborhood obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.municipalityId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeighborhoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Neighborhood _$NeighborhoodFromJson(Map<String, dynamic> json) => Neighborhood(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NeighborhoodToJson(Neighborhood instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'municipality_id': instance.municipalityId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
