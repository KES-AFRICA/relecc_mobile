// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_filter_options_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NetworkFilterOptionsResponseAdapter
    extends TypeAdapter<NetworkFilterOptionsResponse> {
  @override
  final int typeId = 110;

  @override
  NetworkFilterOptionsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NetworkFilterOptionsResponse(
      success: fields[0] as bool,
      error: fields[1] as bool,
      message: fields[2] as String,
      data: fields[3] as FilterOptionsData,
    );
  }

  @override
  void write(BinaryWriter writer, NetworkFilterOptionsResponse obj) {
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
      other is NetworkFilterOptionsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterOptionsDataAdapter extends TypeAdapter<FilterOptionsData> {
  @override
  final int typeId = 111;

  @override
  FilterOptionsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterOptionsData(
      networkTypes: (fields[0] as List).cast<FilterOption>(),
      municipalities: (fields[1] as List).cast<FilterOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, FilterOptionsData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.networkTypes)
      ..writeByte(1)
      ..write(obj.municipalities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterOptionsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterOptionAdapter extends TypeAdapter<FilterOption> {
  @override
  final int typeId = 112;

  @override
  FilterOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterOption(
      value: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FilterOption obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkFilterOptionsResponse _$NetworkFilterOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkFilterOptionsResponse(
      success: json['success'] as bool,
      error: json['error'] as bool,
      message: json['message'] as String,
      data: FilterOptionsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkFilterOptionsResponseToJson(
        NetworkFilterOptionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

FilterOptionsData _$FilterOptionsDataFromJson(Map<String, dynamic> json) =>
    FilterOptionsData(
      networkTypes: (json['network_types'] as List<dynamic>)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      municipalities: (json['municipalities'] as List<dynamic>)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterOptionsDataToJson(FilterOptionsData instance) =>
    <String, dynamic>{
      'network_types': instance.networkTypes,
      'municipalities': instance.municipalities,
    };

FilterOption _$FilterOptionFromJson(Map<String, dynamic> json) => FilterOption(
      value: json['value'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$FilterOptionToJson(FilterOption instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };
