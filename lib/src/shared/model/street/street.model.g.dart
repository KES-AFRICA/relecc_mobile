// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreetAdapter extends TypeAdapter<Street> {
  @override
  final int typeId = 18;

  @override
  Street read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Street(
      id: fields[0] as int?,
      municipalityId: fields[1] as int?,
      neighborhoodId: fields[2] as int?,
      name: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      municipality: fields[6] as Municipality?,
      neighborhood: fields[7] as Neighborhood?,
      pivot: fields[8] as Pivot?,
    );
  }

  @override
  void write(BinaryWriter writer, Street obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.municipalityId)
      ..writeByte(2)
      ..write(obj.neighborhoodId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.municipality)
      ..writeByte(7)
      ..write(obj.neighborhood)
      ..writeByte(8)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Street _$StreetFromJson(Map<String, dynamic> json) => Street(
      id: (json['id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      neighborhoodId: (json['neighborhood_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      municipality: json['municipality'] == null
          ? null
          : Municipality.fromJson(json['municipality'] as Map<String, dynamic>),
      neighborhood: json['neighborhood'] == null
          ? null
          : Neighborhood.fromJson(json['neighborhood'] as Map<String, dynamic>),
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreetToJson(Street instance) => <String, dynamic>{
      'id': instance.id,
      'municipality_id': instance.municipalityId,
      'neighborhood_id': instance.neighborhoodId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'municipality': instance.municipality,
      'neighborhood': instance.neighborhood,
      'pivot': instance.pivot,
    };
