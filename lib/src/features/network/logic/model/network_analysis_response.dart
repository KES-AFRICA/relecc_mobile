import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_analysis_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 100)
class NetworkAnalysisResponse extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'success')
  final bool success;

  @HiveField(1)
  @JsonKey(name: 'error')
  final bool error;

  @HiveField(2)
  @JsonKey(name: 'message')
  final String message;

  @HiveField(3)
  @JsonKey(name: 'data')
  final NetworkAnalysisData? data; // Nullable car peut être null

  NetworkAnalysisResponse({
    required this.success,
    required this.error,
    required this.message,
    this.data, // Nullable
  });

  factory NetworkAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkAnalysisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkAnalysisResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 101)
class NetworkAnalysisData extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'networks')
  final List<NetworkAnalysis>? networks; // Nullable

  @HiveField(1)
  @JsonKey(name: 'statistics')
  final NetworkStatistics? statistics; // Nullable

  @HiveField(2)
  @JsonKey(name: 'meta')
  final NetworkMeta? meta; // Nullable

  NetworkAnalysisData({
    this.networks,
    this.statistics,
    this.meta,
  });

  factory NetworkAnalysisData.fromJson(Map<String, dynamic> json) =>
      _$NetworkAnalysisDataFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkAnalysisDataToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 102)
class NetworkAnalysis extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'type')
  final String type;

  @HiveField(1)
  @JsonKey(name: 'type_label')
  final String typeLabel;

  @HiveField(2)
  @JsonKey(name: 'id')
  final String id;

  @HiveField(3)
  @JsonKey(name: 'streetlights')
  final List<dynamic>? streetlights; // Nullable

  @HiveField(4)
  @JsonKey(name: 'municipality')
  final String municipality;

  @HiveField(5)
  @JsonKey(name: 'cabinet_name')
  final String? cabinetName; // Nullable

  @HiveField(6)
  @JsonKey(name: 'meter_name')
  final String? meterName; // Nullable

  @HiveField(7)
  @JsonKey(name: 'streetlight_count')
  final int streetlightCount;

  @HiveField(8)
  @JsonKey(name: 'total_power')
  final double totalPower;

  @HiveField(9)
  @JsonKey(name: 'distance')
  final double distance;

  @HiveField(10)
  @JsonKey(name: 'on_day_percentage')
  final double onDayPercentage;

  @HiveField(11)
  @JsonKey(name: 'on_night_percentage')
  final double onNightPercentage;

  @HiveField(12)
  @JsonKey(name: 'created_at_formatted')
  final String createdAtFormatted;

  @HiveField(13)
  @JsonKey(name: 'age_days')
  final int ageDays;

  @HiveField(14)
  @JsonKey(name: 'streetlight_types')
  final List<TypeDistribution>? streetlightTypes; // Nullable

  @HiveField(15)
  @JsonKey(name: 'lamp_types')
  final List<TypeDistribution>? lampTypes; // Nullable

  @HiveField(16)
  @JsonKey(name: 'cabinet_id')
  final int? cabinetId; // Nullable

  @HiveField(17)
  @JsonKey(name: 'meter_id')
  final int? meterId; // Nullable

  @HiveField(18)
  @JsonKey(name: 'municipality_id')
  final int municipalityId;

  @HiveField(19)
  @JsonKey(name: 'created_at_iso')
  final String createdAtIso;

  NetworkAnalysis({
    required this.type,
    required this.typeLabel,
    required this.id,
    this.streetlights,
    required this.municipality,
    this.cabinetName,
    this.meterName,
    required this.streetlightCount,
    required this.totalPower,
    required this.distance,
    required this.onDayPercentage,
    required this.onNightPercentage,
    required this.createdAtFormatted,
    required this.ageDays,
    this.streetlightTypes,
    this.lampTypes,
    this.cabinetId,
    this.meterId,
    required this.municipalityId,
    required this.createdAtIso,
  });

  factory NetworkAnalysis.fromJson(Map<String, dynamic> json) =>
      _$NetworkAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkAnalysisToJson(this);

  String get displayType {
    switch (type) {
      case 'with_cabinet_meter':
        return 'Cabinet + Compteur';
      case 'with_cabinet_only':
        return 'Cabinet seul';
      case 'with_meter_only':
        return 'Compteur seul';
      default:
        return typeLabel;
    }
  }
}

@JsonSerializable()
@HiveType(typeId: 103)
class TypeDistribution extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'count')
  final int count;

  @HiveField(2)
  @JsonKey(name: 'percentage')
  final double percentage;

  TypeDistribution({
    required this.name,
    required this.count,
    required this.percentage,
  });

  factory TypeDistribution.fromJson(Map<String, dynamic> json) =>
      _$TypeDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDistributionToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 104)
class NetworkStatistics extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'total_networks')
  final int totalNetworks;

  @HiveField(1)
  @JsonKey(name: 'total_streetlights')
  final int totalStreetlights;

  @HiveField(2)
  @JsonKey(name: 'total_power_w')
  final double totalPowerW;

  @HiveField(3)
  @JsonKey(name: 'total_distance_km')
  final double totalDistanceKm;

  @HiveField(4)
  @JsonKey(name: 'total_on_day')
  final int totalOnDay;

  @HiveField(5)
  @JsonKey(name: 'total_on_night')
  final int totalOnNight;

  @HiveField(6)
  @JsonKey(name: 'by_type')
  final Map<String, NetworkTypeStats>? byType; // Nullable

  @HiveField(7)
  @JsonKey(name: 'by_municipality')
  final List<MunicipalityStats>? byMunicipality; // Nullable

  @HiveField(8)
  @JsonKey(name: 'creation_stats')
  final CreationStats? creationStats; // Nullable

  NetworkStatistics({
    required this.totalNetworks,
    required this.totalStreetlights,
    required this.totalPowerW,
    required this.totalDistanceKm,
    required this.totalOnDay,
    required this.totalOnNight,
    this.byType,
    this.byMunicipality,
    this.creationStats,
  });

  factory NetworkStatistics.fromJson(Map<String, dynamic> json) =>
      _$NetworkStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkStatisticsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 105)
class NetworkTypeStats extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'count')
  final int count;

  @HiveField(1)
  @JsonKey(name: 'streetlights')
  final int streetlights;

  @HiveField(2)
  @JsonKey(name: 'distance')
  final double distance;

  @HiveField(3)
  @JsonKey(name: 'power')
  final double power;

  @HiveField(4)
  @JsonKey(name: 'on_day')
  final int onDay;

  @HiveField(5)
  @JsonKey(name: 'on_night')
  final int onNight;

  @HiveField(6)
  @JsonKey(name: 'power_kw')
  final double powerKw;

  @HiveField(7)
  @JsonKey(name: 'on_day_percentage')
  final double onDayPercentage;

  @HiveField(8)
  @JsonKey(name: 'on_night_percentage')
  final double onNightPercentage;

  NetworkTypeStats({
    required this.count,
    required this.streetlights,
    required this.distance,
    required this.power,
    required this.onDay,
    required this.onNight,
    required this.powerKw,
    required this.onDayPercentage,
    required this.onNightPercentage,
  });

  factory NetworkTypeStats.fromJson(Map<String, dynamic> json) =>
      _$NetworkTypeStatsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkTypeStatsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 106)
class MunicipalityStats extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'count')
  final int count;

  @HiveField(2)
  @JsonKey(name: 'streetlights')
  final int streetlights;

  @HiveField(3)
  @JsonKey(name: 'distance')
  final double distance;

  @HiveField(4)
  @JsonKey(name: 'power')
  final double power;

  @HiveField(5)
  @JsonKey(name: 'power_kw')
  final double powerKw;

  MunicipalityStats({
    required this.name,
    required this.count,
    required this.streetlights,
    required this.distance,
    required this.power,
    required this.powerKw,
  });

  factory MunicipalityStats.fromJson(Map<String, dynamic> json) =>
      _$MunicipalityStatsFromJson(json);

  Map<String, dynamic> toJson() => _$MunicipalityStatsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 107)
class CreationStats extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'newest_network_days_ago')
  final int newestNetworkDaysAgo;

  @HiveField(1)
  @JsonKey(name: 'oldest_network_days_ago')
  final int oldestNetworkDaysAgo;

  @HiveField(2)
  @JsonKey(name: 'average_network_age_days')
  final double averageNetworkAgeDays;

  CreationStats({
    required this.newestNetworkDaysAgo,
    required this.oldestNetworkDaysAgo,
    required this.averageNetworkAgeDays,
  });

  factory CreationStats.fromJson(Map<String, dynamic> json) =>
      _$CreationStatsFromJson(json);

  Map<String, dynamic> toJson() => _$CreationStatsToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 108)
class NetworkMeta extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'current_page')
  final int currentPage;

  @HiveField(1)
  @JsonKey(name: 'last_page')
  final int lastPage;

  @HiveField(2)
  @JsonKey(name: 'per_page')
  final int perPage;

  @HiveField(3)
  @JsonKey(name: 'total')
  final int total;

  @HiveField(4)
  @JsonKey(name: 'total_networks')
  final int totalNetworks;

  NetworkMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.totalNetworks,
  });

  factory NetworkMeta.fromJson(Map<String, dynamic> json) =>
      _$NetworkMetaFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkMetaToJson(this);

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
}
