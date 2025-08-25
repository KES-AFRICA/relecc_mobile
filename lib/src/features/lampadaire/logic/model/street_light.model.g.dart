// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street_light.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreetLightInformationAdapter
    extends TypeAdapter<StreetLightInformation> {
  @override
  final int typeId = 4;

  @override
  StreetLightInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreetLightInformation(
      typeLampadaires: (fields[0] as List?)?.cast<Common>(),
      reseaux: (fields[1] as List?)?.cast<Common>(),
      typeDeLampe: (fields[2] as List?)?.cast<Common>(),
      couleurs: (fields[3] as List?)?.cast<Common>(),
      orientations: (fields[4] as List?)?.cast<Common>(),
      voies: (fields[5] as List?)?.cast<Common>(),
      commandes: (fields[6] as List?)?.cast<Common>(),
      typesDeSupport: (fields[7] as List?)?.cast<Common>(),
      conditionsDeSupport: (fields[8] as List?)?.cast<Common>(),
      municipalites: (fields[9] as List?)?.cast<Common>(),
      streets: (fields[10] as List?)?.cast<Common>(),
    );
  }

  @override
  void write(BinaryWriter writer, StreetLightInformation obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.typeLampadaires)
      ..writeByte(1)
      ..write(obj.reseaux)
      ..writeByte(2)
      ..write(obj.typeDeLampe)
      ..writeByte(3)
      ..write(obj.couleurs)
      ..writeByte(4)
      ..write(obj.orientations)
      ..writeByte(5)
      ..write(obj.voies)
      ..writeByte(6)
      ..write(obj.commandes)
      ..writeByte(7)
      ..write(obj.typesDeSupport)
      ..writeByte(8)
      ..write(obj.conditionsDeSupport)
      ..writeByte(9)
      ..write(obj.municipalites)
      ..writeByte(10)
      ..write(obj.streets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreetLightInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreStreetLightInformationAdapter
    extends TypeAdapter<StoreStreetLightInformation> {
  @override
  final int typeId = 5;

  @override
  StoreStreetLightInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreStreetLightInformation(
      qrcode: fields[0] as String?,
      meterId: fields[12] as int?,
      street: fields[9] as String,
      streetlighttypeId: fields[1] as int,
      networkId: fields[2] as int,
      orientationId: fields[3] as int,
      trackId: fields[4] as int,
      commandTypeId: fields[5] as int,
      supportTypeId: fields[6] as int,
      supportConditionId: fields[7] as int,
      location: fields[8] as String,
      lampCount: fields[10] as int,
      cabinetId: fields[11] as int?,
      municipalityId: fields[13] as int,
      lamps: (fields[14] as List?)?.cast<StoreStreetLampInformation>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoreStreetLightInformation obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.qrcode)
      ..writeByte(1)
      ..write(obj.streetlighttypeId)
      ..writeByte(2)
      ..write(obj.networkId)
      ..writeByte(3)
      ..write(obj.orientationId)
      ..writeByte(4)
      ..write(obj.trackId)
      ..writeByte(5)
      ..write(obj.commandTypeId)
      ..writeByte(6)
      ..write(obj.supportTypeId)
      ..writeByte(7)
      ..write(obj.supportConditionId)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.street)
      ..writeByte(10)
      ..write(obj.lampCount)
      ..writeByte(11)
      ..write(obj.cabinetId)
      ..writeByte(12)
      ..write(obj.meterId)
      ..writeByte(13)
      ..write(obj.municipalityId)
      ..writeByte(14)
      ..write(obj.lamps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreStreetLightInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreStreetLampInformationAdapter
    extends TypeAdapter<StoreStreetLampInformation> {
  @override
  final int typeId = 6;

  @override
  StoreStreetLampInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreStreetLampInformation(
      lampTypeId: fields[0] as int?,
      power: fields[1] as int?,
      colorId: fields[2] as int?,
      hasLamp: fields[3] as int?,
      withbalast: fields[4] as int?,
      isOnDay: fields[5] as int?,
      isOnNight: fields[6] as int?,
      lamp_type: fields[7] as String?,
      lamp_color: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreStreetLampInformation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.lampTypeId)
      ..writeByte(1)
      ..write(obj.power)
      ..writeByte(2)
      ..write(obj.colorId)
      ..writeByte(3)
      ..write(obj.hasLamp)
      ..writeByte(4)
      ..write(obj.withbalast)
      ..writeByte(5)
      ..write(obj.isOnDay)
      ..writeByte(6)
      ..write(obj.isOnNight)
      ..writeByte(7)
      ..write(obj.lamp_type)
      ..writeByte(8)
      ..write(obj.lamp_color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreStreetLampInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreStreetLightResponseAdapter
    extends TypeAdapter<StoreStreetLightResponse> {
  @override
  final int typeId = 7;

  @override
  StoreStreetLightResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreStreetLightResponse(
      id: fields[0] as int?,
      name: fields[1] as String?,
      power: fields[2] as int?,
      isOnDay: fields[3] as int?,
      isOnNight: fields[4] as int?,
      photo: fields[5] as String?,
      location: fields[6] as String?,
      lampCount: fields[7] as int?,
      streetLightTypeId: fields[8] as int?,
      qrcodeId: fields[9] as int?,
      networkId: fields[10] as int?,
      orientationId: fields[11] as int?,
      trackId: fields[12] as int?,
      commandTypeId: fields[13] as int?,
      supportTypeId: fields[14] as int?,
      supportConditionId: fields[15] as int?,
      streetId: fields[16] as int?,
      meterId: fields[17] as int?,
      municipalityId: fields[18] as int?,
      cabinetId: fields[19] as int?,
      streetLightType: fields[20] as Common?,
      network: fields[21] as Common?,
      orientation: fields[22] as Common?,
      track: fields[23] as Common?,
      supportType: fields[24] as Common?,
      supportCondition: fields[25] as Common?,
      street: fields[26] as Common?,
      municipality: fields[27] as Common?,
      cabinet: fields[28] as CabinetResponse?,
      createdAt: fields[29] as DateTime?,
      updatedAt: fields[30] as DateTime?,
      lamps: (fields[31] as List?)?.cast<StoreStreetLampInformation>(),
      report: fields[32] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreStreetLightResponse obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.power)
      ..writeByte(3)
      ..write(obj.isOnDay)
      ..writeByte(4)
      ..write(obj.isOnNight)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.lampCount)
      ..writeByte(8)
      ..write(obj.streetLightTypeId)
      ..writeByte(9)
      ..write(obj.qrcodeId)
      ..writeByte(10)
      ..write(obj.networkId)
      ..writeByte(11)
      ..write(obj.orientationId)
      ..writeByte(12)
      ..write(obj.trackId)
      ..writeByte(13)
      ..write(obj.commandTypeId)
      ..writeByte(14)
      ..write(obj.supportTypeId)
      ..writeByte(15)
      ..write(obj.supportConditionId)
      ..writeByte(16)
      ..write(obj.streetId)
      ..writeByte(17)
      ..write(obj.meterId)
      ..writeByte(18)
      ..write(obj.municipalityId)
      ..writeByte(19)
      ..write(obj.cabinetId)
      ..writeByte(20)
      ..write(obj.streetLightType)
      ..writeByte(21)
      ..write(obj.network)
      ..writeByte(22)
      ..write(obj.orientation)
      ..writeByte(23)
      ..write(obj.track)
      ..writeByte(24)
      ..write(obj.supportType)
      ..writeByte(25)
      ..write(obj.supportCondition)
      ..writeByte(26)
      ..write(obj.street)
      ..writeByte(27)
      ..write(obj.municipality)
      ..writeByte(28)
      ..write(obj.cabinet)
      ..writeByte(29)
      ..write(obj.createdAt)
      ..writeByte(30)
      ..write(obj.updatedAt)
      ..writeByte(31)
      ..write(obj.lamps)
      ..writeByte(32)
      ..write(obj.report);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreStreetLightResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreStreetLightResponseCompletAdapter
    extends TypeAdapter<StoreStreetLightResponseComplet> {
  @override
  final int typeId = 8;

  @override
  StoreStreetLightResponseComplet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreStreetLightResponseComplet(
      id: fields[0] as int?,
      name: fields[1] as String?,
      power: fields[2] as int?,
      isOnDay: fields[3] as int?,
      isOnNight: fields[4] as int?,
      photo: fields[5] as String?,
      location: fields[6] as String?,
      lampCount: fields[7] as int?,
      streetLightTypeId: fields[8] as int?,
      qrcodeId: fields[9] as int?,
      networkId: fields[10] as int?,
      orientationId: fields[11] as int?,
      trackId: fields[12] as int?,
      commandTypeId: fields[13] as int?,
      supportTypeId: fields[14] as int?,
      supportConditionId: fields[15] as int?,
      streetId: fields[16] as int?,
      meterId: fields[17] as int?,
      municipalityId: fields[18] as int?,
      cabinetId: fields[19] as int?,
      streetLightType: fields[20] as String?,
      network: fields[21] as String?,
      orientation: fields[22] as String?,
      track: fields[23] as String?,
      supportType: fields[24] as String?,
      supportCondition: fields[25] as String?,
      street: fields[26] as String?,
      municipality: fields[27] as String?,
      cabinet: fields[28] as CabinetResponse?,
      createdAt: fields[29] as DateTime?,
      updatedAt: fields[30] as DateTime?,
      lamps: (fields[31] as List?)?.cast<StoreStreetLampInformation>(),
      report: fields[32] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreStreetLightResponseComplet obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.power)
      ..writeByte(3)
      ..write(obj.isOnDay)
      ..writeByte(4)
      ..write(obj.isOnNight)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.lampCount)
      ..writeByte(8)
      ..write(obj.streetLightTypeId)
      ..writeByte(9)
      ..write(obj.qrcodeId)
      ..writeByte(10)
      ..write(obj.networkId)
      ..writeByte(11)
      ..write(obj.orientationId)
      ..writeByte(12)
      ..write(obj.trackId)
      ..writeByte(13)
      ..write(obj.commandTypeId)
      ..writeByte(14)
      ..write(obj.supportTypeId)
      ..writeByte(15)
      ..write(obj.supportConditionId)
      ..writeByte(16)
      ..write(obj.streetId)
      ..writeByte(17)
      ..write(obj.meterId)
      ..writeByte(18)
      ..write(obj.municipalityId)
      ..writeByte(19)
      ..write(obj.cabinetId)
      ..writeByte(20)
      ..write(obj.streetLightType)
      ..writeByte(21)
      ..write(obj.network)
      ..writeByte(22)
      ..write(obj.orientation)
      ..writeByte(23)
      ..write(obj.track)
      ..writeByte(24)
      ..write(obj.supportType)
      ..writeByte(25)
      ..write(obj.supportCondition)
      ..writeByte(26)
      ..write(obj.street)
      ..writeByte(27)
      ..write(obj.municipality)
      ..writeByte(28)
      ..write(obj.cabinet)
      ..writeByte(29)
      ..write(obj.createdAt)
      ..writeByte(30)
      ..write(obj.updatedAt)
      ..writeByte(31)
      ..write(obj.lamps)
      ..writeByte(32)
      ..write(obj.report);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreStreetLightResponseCompletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreetLightInformation _$StreetLightInformationFromJson(
        Map<String, dynamic> json) =>
    StreetLightInformation(
      typeLampadaires: (json['TypeLampadaires'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      reseaux: (json['Réseaux'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeDeLampe: (json['TypeDeLampe'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      couleurs: (json['Couleurs'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      orientations: (json['Orientations'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      voies: (json['Voies'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      commandes: (json['Commandes'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      typesDeSupport: (json['TypesDeSupport'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      conditionsDeSupport: (json['ConditionsDeSupport'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      municipalites: (json['Municipalites'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
      streets: (json['streets'] as List<dynamic>?)
          ?.map((e) => Common.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StreetLightInformationToJson(
        StreetLightInformation instance) =>
    <String, dynamic>{
      'TypeLampadaires': instance.typeLampadaires,
      'Réseaux': instance.reseaux,
      'TypeDeLampe': instance.typeDeLampe,
      'Couleurs': instance.couleurs,
      'Orientations': instance.orientations,
      'Voies': instance.voies,
      'Commandes': instance.commandes,
      'TypesDeSupport': instance.typesDeSupport,
      'ConditionsDeSupport': instance.conditionsDeSupport,
      'Municipalites': instance.municipalites,
      'streets': instance.streets,
    };

StoreStreetLightInformation _$StoreStreetLightInformationFromJson(
        Map<String, dynamic> json) =>
    StoreStreetLightInformation(
      qrcode: json['qrcode'] as String?,
      meterId: (json['meter_id'] as num?)?.toInt(),
      street: json['street'] as String,
      streetlighttypeId: (json['streetlight_type_id'] as num).toInt(),
      networkId: (json['network_id'] as num).toInt(),
      orientationId: (json['orientation_id'] as num).toInt(),
      trackId: (json['track_id'] as num).toInt(),
      commandTypeId: (json['command_type_id'] as num).toInt(),
      supportTypeId: (json['support_type_id'] as num).toInt(),
      supportConditionId: (json['support_condition_id'] as num).toInt(),
      location: json['location'] as String,
      lampCount: (json['lamp_count'] as num).toInt(),
      cabinetId: (json['cabinet_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num).toInt(),
      lamps: (json['lamps'] as List<dynamic>?)
          ?.map((e) =>
              StoreStreetLampInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreStreetLightInformationToJson(
        StoreStreetLightInformation instance) =>
    <String, dynamic>{
      'qrcode': instance.qrcode,
      'streetlight_type_id': instance.streetlighttypeId,
      'network_id': instance.networkId,
      'orientation_id': instance.orientationId,
      'track_id': instance.trackId,
      'command_type_id': instance.commandTypeId,
      'support_type_id': instance.supportTypeId,
      'support_condition_id': instance.supportConditionId,
      'location': instance.location,
      'street': instance.street,
      'lamp_count': instance.lampCount,
      'cabinet_id': instance.cabinetId,
      'meter_id': instance.meterId,
      'municipality_id': instance.municipalityId,
      'lamps': instance.lamps,
    };

StoreStreetLampInformation _$StoreStreetLampInformationFromJson(
        Map<String, dynamic> json) =>
    StoreStreetLampInformation(
      lampTypeId: (json['lamp_type_id'] as num?)?.toInt(),
      power: (json['power'] as num?)?.toInt(),
      colorId: (json['color_id'] as num?)?.toInt(),
      hasLamp: (json['has_lamp'] as num?)?.toInt(),
      withbalast: (json['with_balast'] as num?)?.toInt(),
      isOnDay: (json['is_on_day'] as num?)?.toInt(),
      isOnNight: (json['is_on_night'] as num?)?.toInt(),
      lamp_type: json['lamp_type'] as String?,
      lamp_color: json['lamp_color'] as String?,
    );

Map<String, dynamic> _$StoreStreetLampInformationToJson(
        StoreStreetLampInformation instance) =>
    <String, dynamic>{
      'lamp_type_id': instance.lampTypeId,
      'power': instance.power,
      'color_id': instance.colorId,
      'has_lamp': instance.hasLamp,
      'with_balast': instance.withbalast,
      'is_on_day': instance.isOnDay,
      'is_on_night': instance.isOnNight,
      'lamp_type': instance.lamp_type,
      'lamp_color': instance.lamp_color,
    };

StoreStreetLightResponse _$StoreStreetLightResponseFromJson(
        Map<String, dynamic> json) =>
    StoreStreetLightResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      power: (json['power'] as num?)?.toInt(),
      isOnDay: (json['is_on_day'] as num?)?.toInt(),
      isOnNight: (json['is_on_night'] as num?)?.toInt(),
      photo: json['photo'] as String?,
      location: json['location'] as String?,
      lampCount: (json['lamp_count'] as num?)?.toInt(),
      streetLightTypeId: (json['streetlight_type_id'] as num?)?.toInt(),
      qrcodeId: (json['qrcode_id'] as num?)?.toInt(),
      networkId: (json['network_id'] as num?)?.toInt(),
      orientationId: (json['orientation_id'] as num?)?.toInt(),
      trackId: (json['track_id'] as num?)?.toInt(),
      commandTypeId: (json['command_type_id'] as num?)?.toInt(),
      supportTypeId: (json['support_type_id'] as num?)?.toInt(),
      supportConditionId: (json['support_condition_id'] as num?)?.toInt(),
      streetId: (json['street_id'] as num?)?.toInt(),
      meterId: (json['meter_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      cabinetId: (json['cabinet_id'] as num?)?.toInt(),
      streetLightType: json['streetlight_type'] == null
          ? null
          : Common.fromJson(json['streetlight_type'] as Map<String, dynamic>),
      network: json['network'] == null
          ? null
          : Common.fromJson(json['network'] as Map<String, dynamic>),
      orientation: json['orientation'] == null
          ? null
          : Common.fromJson(json['orientation'] as Map<String, dynamic>),
      track: json['track'] == null
          ? null
          : Common.fromJson(json['track'] as Map<String, dynamic>),
      commandType: json['command_type'] == null
          ? null
          : Common.fromJson(json['command_type'] as Map<String, dynamic>),
      supportType: json['support_type'] == null
          ? null
          : Common.fromJson(json['support_type'] as Map<String, dynamic>),
      supportCondition: json['support_condition'] == null
          ? null
          : Common.fromJson(json['support_condition'] as Map<String, dynamic>),
      street: json['street'] == null
          ? null
          : Common.fromJson(json['street'] as Map<String, dynamic>),
      municipality: json['municipality'] == null
          ? null
          : Common.fromJson(json['municipality'] as Map<String, dynamic>),
      cabinet: json['cabinet'] == null
          ? null
          : CabinetResponse.fromJson(json['cabinet'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lamps: (json['lamps'] as List<dynamic>?)
          ?.map((e) =>
              StoreStreetLampInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      report: json['report'] as String?,
    );

Map<String, dynamic> _$StoreStreetLightResponseToJson(
        StoreStreetLightResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'power': instance.power,
      'is_on_day': instance.isOnDay,
      'is_on_night': instance.isOnNight,
      'photo': instance.photo,
      'location': instance.location,
      'lamp_count': instance.lampCount,
      'streetlight_type_id': instance.streetLightTypeId,
      'qrcode_id': instance.qrcodeId,
      'network_id': instance.networkId,
      'orientation_id': instance.orientationId,
      'track_id': instance.trackId,
      'command_type_id': instance.commandTypeId,
      'support_type_id': instance.supportTypeId,
      'support_condition_id': instance.supportConditionId,
      'street_id': instance.streetId,
      'meter_id': instance.meterId,
      'municipality_id': instance.municipalityId,
      'cabinet_id': instance.cabinetId,
      'streetlight_type': instance.streetLightType,
      'network': instance.network,
      'orientation': instance.orientation,
      'track': instance.track,
      'command_type': instance.commandType,
      'support_type': instance.supportType,
      'support_condition': instance.supportCondition,
      'street': instance.street,
      'municipality': instance.municipality,
      'cabinet': instance.cabinet,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'lamps': instance.lamps,
      'report': instance.report,
    };

StoreStreetLightResponseComplet _$StoreStreetLightResponseCompletFromJson(
        Map<String, dynamic> json) =>
    StoreStreetLightResponseComplet(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      power: (json['power'] as num?)?.toInt(),
      isOnDay: (json['is_on_day'] as num?)?.toInt(),
      isOnNight: (json['is_on_night'] as num?)?.toInt(),
      photo: json['photo'] as String?,
      location: json['location'] as String?,
      lampCount: (json['lamp_count'] as num?)?.toInt(),
      streetLightTypeId: (json['streetlight_type_id'] as num?)?.toInt(),
      qrcodeId: (json['qrcode_id'] as num?)?.toInt(),
      networkId: (json['network_id'] as num?)?.toInt(),
      orientationId: (json['orientation_id'] as num?)?.toInt(),
      trackId: (json['track_id'] as num?)?.toInt(),
      commandTypeId: (json['command_type_id'] as num?)?.toInt(),
      supportTypeId: (json['support_type_id'] as num?)?.toInt(),
      supportConditionId: (json['support_condition_id'] as num?)?.toInt(),
      streetId: (json['street_id'] as num?)?.toInt(),
      meterId: (json['meter_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      cabinetId: (json['cabinet_id'] as num?)?.toInt(),
      streetLightType: json['streetlight_type'] as String?,
      network: json['network'] as String?,
      orientation: json['orientation'] as String?,
      track: json['track'] as String?,
      commandType: json['command_type'] as String?,
      supportType: json['support_type'] as String?,
      supportCondition: json['support_condition'] as String?,
      street: json['street'] as String?,
      municipality: json['municipality'] as String?,
      cabinet: json['cabinet'] == null
          ? null
          : CabinetResponse.fromJson(json['cabinet'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lamps: (json['lamps'] as List<dynamic>?)
          ?.map((e) =>
              StoreStreetLampInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      report: json['report'] as String?,
    );

Map<String, dynamic> _$StoreStreetLightResponseCompletToJson(
        StoreStreetLightResponseComplet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'power': instance.power,
      'is_on_day': instance.isOnDay,
      'is_on_night': instance.isOnNight,
      'photo': instance.photo,
      'location': instance.location,
      'lamp_count': instance.lampCount,
      'streetlight_type_id': instance.streetLightTypeId,
      'qrcode_id': instance.qrcodeId,
      'network_id': instance.networkId,
      'orientation_id': instance.orientationId,
      'track_id': instance.trackId,
      'command_type_id': instance.commandTypeId,
      'support_type_id': instance.supportTypeId,
      'support_condition_id': instance.supportConditionId,
      'street_id': instance.streetId,
      'meter_id': instance.meterId,
      'municipality_id': instance.municipalityId,
      'cabinet_id': instance.cabinetId,
      'streetlight_type': instance.streetLightType,
      'network': instance.network,
      'orientation': instance.orientation,
      'track': instance.track,
      'command_type': instance.commandType,
      'support_type': instance.supportType,
      'support_condition': instance.supportCondition,
      'street': instance.street,
      'municipality': instance.municipality,
      'cabinet': instance.cabinet,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'lamps': instance.lamps,
      'report': instance.report,
    };
