// network_filter_options_response.dart
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_filter_options_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 110)
class NetworkFilterOptionsResponse extends HiveObject {
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
  final FilterOptionsData data;

  NetworkFilterOptionsResponse({
    required this.success,
    required this.error,
    required this.message,
    required this.data,
  });

  factory NetworkFilterOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkFilterOptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkFilterOptionsResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 111)
class FilterOptionsData extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'network_types')
  final List<FilterOption> networkTypes;

  @HiveField(1)
  @JsonKey(name: 'municipalities')
  final List<FilterOption> municipalities;

  FilterOptionsData({
    required this.networkTypes,
    required this.municipalities,
  });

  factory FilterOptionsData.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterOptionsDataToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 112)
class FilterOption extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'value')
  final String value;

  @HiveField(1)
  @JsonKey(name: 'label')
  final String label;

  FilterOption({
    required this.value,
    required this.label,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionFromJson(json);

  Map<String, dynamic> toJson() => _$FilterOptionToJson(this);
}