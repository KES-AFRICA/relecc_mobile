// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MissionResponseAdapter extends TypeAdapter<MissionResponse> {
  @override
  final int typeId = 16;

  @override
  MissionResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MissionResponse(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      userId: fields[3] as int?,
      interventionTypeId: fields[4] as int?,
      networkType: fields[5] as String?,
      status: fields[6] as String?,
      startedAt: fields[7] as String?,
      finishedAt: fields[8] as String?,
      createdAt: fields[9] as String?,
      updatedAt: fields[10] as String?,
      streets: (fields[11] as List?)?.cast<Street>(),
      interventionType: fields[12] as InterventionType?,
    );
  }

  @override
  void write(BinaryWriter writer, MissionResponse obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.interventionTypeId)
      ..writeByte(5)
      ..write(obj.networkType)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.startedAt)
      ..writeByte(8)
      ..write(obj.finishedAt)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.streets)
      ..writeByte(12)
      ..write(obj.interventionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MissionAdapter extends TypeAdapter<Mission> {
  @override
  final int typeId = 17;

  @override
  Mission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mission(
      mission: fields[0] as MissionResponse?,
    );
  }

  @override
  void write(BinaryWriter writer, Mission obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.mission);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionResponse _$MissionResponseFromJson(Map<String, dynamic> json) =>
    MissionResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      interventionTypeId: (json['intervention_type_id'] as num?)?.toInt(),
      networkType: json['network_type'] as String?,
      status: json['status'] as String?,
      startedAt: json['started_at'] as String?,
      finishedAt: json['finished_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      streets: (json['streets'] as List<dynamic>?)
          ?.map((e) => Street.fromJson(e as Map<String, dynamic>))
          .toList(),
      interventionType: json['intervention_type'] == null
          ? null
          : InterventionType.fromJson(
              json['intervention_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MissionResponseToJson(MissionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'user_id': instance.userId,
      'intervention_type_id': instance.interventionTypeId,
      'network_type': instance.networkType,
      'status': instance.status,
      'started_at': instance.startedAt,
      'finished_at': instance.finishedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'streets': instance.streets,
      'intervention_type': instance.interventionType,
    };

Mission _$MissionFromJson(Map<String, dynamic> json) => Mission(
      mission: json['mission'] == null
          ? null
          : MissionResponse.fromJson(json['mission'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MissionToJson(Mission instance) => <String, dynamic>{
      'mission': instance.mission,
    };
