// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommonAdapter extends TypeAdapter<Common> {
  @override
  final int typeId = 8;

  @override
  Common read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Common(
      municipalityId: fields[1] as int?,
      hex: fields[4] as String?,
      id: fields[0] as int,
      name: fields[2] as String,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Common obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.municipalityId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.hex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Common _$CommonFromJson(Map<String, dynamic> json) => Common(
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      hex: json['hex'] as String?,
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CommonToJson(Common instance) => <String, dynamic>{
      'id': instance.id,
      'municipality_id': instance.municipalityId,
      'name': instance.name,
      'description': instance.description,
      'hex': instance.hex,
    };
