// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_analysis_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NetworkAnalysisResponseAdapter
    extends TypeAdapter<NetworkAnalysisResponse> {
  @override
  final int typeId = 100;

  @override
  NetworkAnalysisResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkAnalysisResponse(
      success: fields[0] as bool,
      error: fields[1] as bool,
      message: fields[2] as String,
      data: fields[3] as NetworkAnalysisData?,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkAnalysisResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.error)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkAnalysisResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NetworkAnalysisDataAdapter extends TypeAdapter<NetworkAnalysisData> {
  @override
  final int typeId = 101;

  @override
  NetworkAnalysisData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkAnalysisData(
      networks: (fields[0] as List?)?.cast<NetworkAnalysis>(),
      statistics: fields[1] as NetworkStatistics?,
      meta: fields[2] as NetworkMeta?,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkAnalysisData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.networks)
      ..writeByte(1)
      ..write(obj.statistics)
      ..writeByte(2)
      ..write(obj.meta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkAnalysisDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NetworkAnalysisAdapter extends TypeAdapter<NetworkAnalysis> {
  @override
  final int typeId = 102;

  @override
  NetworkAnalysis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkAnalysis(
      type: fields[0] as String,
      typeLabel: fields[1] as String,
      id: fields[2] as String,
      streetlights: (fields[3] as List?)?.cast<dynamic>(),
      municipality: fields[4] as String,
      cabinetName: fields[5] as String?,
      meterName: fields[6] as String?,
      streetlightCount: fields[7] as int,
      totalPower: fields[8] as double,
      distance: fields[9] as double,
      onDayPercentage: fields[10] as double,
      onNightPercentage: fields[11] as double,
      createdAtFormatted: fields[12] as String,
      ageDays: fields[13] as int,
      streetlightTypes: (fields[14] as List?)?.cast<TypeDistribution>(),
      lampTypes: (fields[15] as List?)?.cast<TypeDistribution>(),
      cabinetId: fields[16] as int?,
      meterId: fields[17] as int?,
      municipalityId: fields[18] as int,
      createdAtIso: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkAnalysis obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.typeLabel)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.streetlights)
      ..writeByte(4)
      ..write(obj.municipality)
      ..writeByte(5)
      ..write(obj.cabinetName)
      ..writeByte(6)
      ..write(obj.meterName)
      ..writeByte(7)
      ..write(obj.streetlightCount)
      ..writeByte(8)
      ..write(obj.totalPower)
      ..writeByte(9)
      ..write(obj.distance)
      ..writeByte(10)
      ..write(obj.onDayPercentage)
      ..writeByte(11)
      ..write(obj.onNightPercentage)
      ..writeByte(12)
      ..write(obj.createdAtFormatted)
      ..writeByte(13)
      ..write(obj.ageDays)
      ..writeByte(14)
      ..write(obj.streetlightTypes)
      ..writeByte(15)
      ..write(obj.lampTypes)
      ..writeByte(16)
      ..write(obj.cabinetId)
      ..writeByte(17)
      ..write(obj.meterId)
      ..writeByte(18)
      ..write(obj.municipalityId)
      ..writeByte(19)
      ..write(obj.createdAtIso);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkAnalysisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeDistributionAdapter extends TypeAdapter<TypeDistribution> {
  @override
  final int typeId = 103;

  @override
  TypeDistribution read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeDistribution(
      name: fields[0] as String,
      count: fields[1] as int,
      percentage: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TypeDistribution obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.percentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeDistributionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NetworkStatisticsAdapter extends TypeAdapter<NetworkStatistics> {
  @override
  final int typeId = 104;

  @override
  NetworkStatistics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkStatistics(
      totalNetworks: fields[0] as int,
      totalStreetlights: fields[1] as int,
      totalPowerW: fields[2] as double,
      totalDistanceKm: fields[3] as double,
      totalOnDay: fields[4] as int,
      totalOnNight: fields[5] as int,
      byType: (fields[6] as Map?)?.cast<String, NetworkTypeStats>(),
      byMunicipality: (fields[7] as List?)?.cast<MunicipalityStats>(),
      creationStats: fields[8] as CreationStats?,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkStatistics obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.totalNetworks)
      ..writeByte(1)
      ..write(obj.totalStreetlights)
      ..writeByte(2)
      ..write(obj.totalPowerW)
      ..writeByte(3)
      ..write(obj.totalDistanceKm)
      ..writeByte(4)
      ..write(obj.totalOnDay)
      ..writeByte(5)
      ..write(obj.totalOnNight)
      ..writeByte(6)
      ..write(obj.byType)
      ..writeByte(7)
      ..write(obj.byMunicipality)
      ..writeByte(8)
      ..write(obj.creationStats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkStatisticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NetworkTypeStatsAdapter extends TypeAdapter<NetworkTypeStats> {
  @override
  final int typeId = 105;

  @override
  NetworkTypeStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkTypeStats(
      count: fields[0] as int,
      streetlights: fields[1] as int,
      distance: fields[2] as double,
      power: fields[3] as double,
      onDay: fields[4] as int,
      onNight: fields[5] as int,
      powerKw: fields[6] as double,
      onDayPercentage: fields[7] as double,
      onNightPercentage: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkTypeStats obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.streetlights)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.power)
      ..writeByte(4)
      ..write(obj.onDay)
      ..writeByte(5)
      ..write(obj.onNight)
      ..writeByte(6)
      ..write(obj.powerKw)
      ..writeByte(7)
      ..write(obj.onDayPercentage)
      ..writeByte(8)
      ..write(obj.onNightPercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkTypeStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MunicipalityStatsAdapter extends TypeAdapter<MunicipalityStats> {
  @override
  final int typeId = 106;

  @override
  MunicipalityStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MunicipalityStats(
      name: fields[0] as String,
      count: fields[1] as int,
      streetlights: fields[2] as int,
      distance: fields[3] as double,
      power: fields[4] as double,
      powerKw: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MunicipalityStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.streetlights)
      ..writeByte(3)
      ..write(obj.distance)
      ..writeByte(4)
      ..write(obj.power)
      ..writeByte(5)
      ..write(obj.powerKw);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MunicipalityStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CreationStatsAdapter extends TypeAdapter<CreationStats> {
  @override
  final int typeId = 107;

  @override
  CreationStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreationStats(
      newestNetworkDaysAgo: fields[0] as int,
      oldestNetworkDaysAgo: fields[1] as int,
      averageNetworkAgeDays: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CreationStats obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.newestNetworkDaysAgo)
      ..writeByte(1)
      ..write(obj.oldestNetworkDaysAgo)
      ..writeByte(2)
      ..write(obj.averageNetworkAgeDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreationStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NetworkMetaAdapter extends TypeAdapter<NetworkMeta> {
  @override
  final int typeId = 108;

  @override
  NetworkMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkMeta(
      currentPage: fields[0] as int,
      lastPage: fields[1] as int,
      perPage: fields[2] as int,
      total: fields[3] as int,
      totalNetworks: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkMeta obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.currentPage)
      ..writeByte(1)
      ..write(obj.lastPage)
      ..writeByte(2)
      ..write(obj.perPage)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.totalNetworks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkAnalysisResponse _$NetworkAnalysisResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkAnalysisResponse(
      success: json['success'] as bool,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : NetworkAnalysisData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkAnalysisResponseToJson(
        NetworkAnalysisResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

NetworkAnalysisData _$NetworkAnalysisDataFromJson(Map<String, dynamic> json) =>
    NetworkAnalysisData(
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => NetworkAnalysis.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: json['statistics'] == null
          ? null
          : NetworkStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : NetworkMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkAnalysisDataToJson(
        NetworkAnalysisData instance) =>
    <String, dynamic>{
      'networks': instance.networks,
      'statistics': instance.statistics,
      'meta': instance.meta,
    };

NetworkAnalysis _$NetworkAnalysisFromJson(Map<String, dynamic> json) =>
    NetworkAnalysis(
      type: json['type'] as String,
      typeLabel: json['type_label'] as String,
      id: json['id'] as String,
      streetlights: json['streetlights'] as List<dynamic>?,
      municipality: json['municipality'] as String,
      cabinetName: json['cabinet_name'] as String?,
      meterName: json['meter_name'] as String?,
      streetlightCount: (json['streetlight_count'] as num).toInt(),
      totalPower: (json['total_power'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      onDayPercentage: (json['on_day_percentage'] as num).toDouble(),
      onNightPercentage: (json['on_night_percentage'] as num).toDouble(),
      createdAtFormatted: json['created_at_formatted'] as String,
      ageDays: (json['age_days'] as num).toInt(),
      streetlightTypes: (json['streetlight_types'] as List<dynamic>?)
          ?.map((e) => TypeDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      lampTypes: (json['lamp_types'] as List<dynamic>?)
          ?.map((e) => TypeDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      cabinetId: (json['cabinet_id'] as num?)?.toInt(),
      meterId: (json['meter_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num).toInt(),
      createdAtIso: json['created_at_iso'] as String,
    );

Map<String, dynamic> _$NetworkAnalysisToJson(NetworkAnalysis instance) =>
    <String, dynamic>{
      'type': instance.type,
      'type_label': instance.typeLabel,
      'id': instance.id,
      'streetlights': instance.streetlights,
      'municipality': instance.municipality,
      'cabinet_name': instance.cabinetName,
      'meter_name': instance.meterName,
      'streetlight_count': instance.streetlightCount,
      'total_power': instance.totalPower,
      'distance': instance.distance,
      'on_day_percentage': instance.onDayPercentage,
      'on_night_percentage': instance.onNightPercentage,
      'created_at_formatted': instance.createdAtFormatted,
      'age_days': instance.ageDays,
      'streetlight_types': instance.streetlightTypes,
      'lamp_types': instance.lampTypes,
      'cabinet_id': instance.cabinetId,
      'meter_id': instance.meterId,
      'municipality_id': instance.municipalityId,
      'created_at_iso': instance.createdAtIso,
    };

TypeDistribution _$TypeDistributionFromJson(Map<String, dynamic> json) =>
    TypeDistribution(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$TypeDistributionToJson(TypeDistribution instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'percentage': instance.percentage,
    };

NetworkStatistics _$NetworkStatisticsFromJson(Map<String, dynamic> json) =>
    NetworkStatistics(
      totalNetworks: (json['total_networks'] as num).toInt(),
      totalStreetlights: (json['total_streetlights'] as num).toInt(),
      totalPowerW: (json['total_power_w'] as num).toDouble(),
      totalDistanceKm: (json['total_distance_km'] as num).toDouble(),
      totalOnDay: (json['total_on_day'] as num).toInt(),
      totalOnNight: (json['total_on_night'] as num).toInt(),
      byType: (json['by_type'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, NetworkTypeStats.fromJson(e as Map<String, dynamic>)),
      ),
      byMunicipality: (json['by_municipality'] as List<dynamic>?)
          ?.map((e) => MunicipalityStats.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationStats: json['creation_stats'] == null
          ? null
          : CreationStats.fromJson(
              json['creation_stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkStatisticsToJson(NetworkStatistics instance) =>
    <String, dynamic>{
      'total_networks': instance.totalNetworks,
      'total_streetlights': instance.totalStreetlights,
      'total_power_w': instance.totalPowerW,
      'total_distance_km': instance.totalDistanceKm,
      'total_on_day': instance.totalOnDay,
      'total_on_night': instance.totalOnNight,
      'by_type': instance.byType,
      'by_municipality': instance.byMunicipality,
      'creation_stats': instance.creationStats,
    };

NetworkTypeStats _$NetworkTypeStatsFromJson(Map<String, dynamic> json) =>
    NetworkTypeStats(
      count: (json['count'] as num).toInt(),
      streetlights: (json['streetlights'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      onDay: (json['on_day'] as num).toInt(),
      onNight: (json['on_night'] as num).toInt(),
      powerKw: (json['power_kw'] as num).toDouble(),
      onDayPercentage: (json['on_day_percentage'] as num).toDouble(),
      onNightPercentage: (json['on_night_percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$NetworkTypeStatsToJson(NetworkTypeStats instance) =>
    <String, dynamic>{
      'count': instance.count,
      'streetlights': instance.streetlights,
      'distance': instance.distance,
      'power': instance.power,
      'on_day': instance.onDay,
      'on_night': instance.onNight,
      'power_kw': instance.powerKw,
      'on_day_percentage': instance.onDayPercentage,
      'on_night_percentage': instance.onNightPercentage,
    };

MunicipalityStats _$MunicipalityStatsFromJson(Map<String, dynamic> json) =>
    MunicipalityStats(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
      streetlights: (json['streetlights'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      powerKw: (json['power_kw'] as num).toDouble(),
    );

Map<String, dynamic> _$MunicipalityStatsToJson(MunicipalityStats instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'streetlights': instance.streetlights,
      'distance': instance.distance,
      'power': instance.power,
      'power_kw': instance.powerKw,
    };

CreationStats _$CreationStatsFromJson(Map<String, dynamic> json) =>
    CreationStats(
      newestNetworkDaysAgo: (json['newest_network_days_ago'] as num).toInt(),
      oldestNetworkDaysAgo: (json['oldest_network_days_ago'] as num).toInt(),
      averageNetworkAgeDays:
          (json['average_network_age_days'] as num).toDouble(),
    );

Map<String, dynamic> _$CreationStatsToJson(CreationStats instance) =>
    <String, dynamic>{
      'newest_network_days_ago': instance.newestNetworkDaysAgo,
      'oldest_network_days_ago': instance.oldestNetworkDaysAgo,
      'average_network_age_days': instance.averageNetworkAgeDays,
    };

NetworkMeta _$NetworkMetaFromJson(Map<String, dynamic> json) => NetworkMeta(
      currentPage: (json['current_page'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalNetworks: (json['total_networks'] as num).toInt(),
    );

Map<String, dynamic> _$NetworkMetaToJson(NetworkMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_networks': instance.totalNetworks,
    };
