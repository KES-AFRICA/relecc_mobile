// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_local_storage.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginLocalStorageAdapter extends TypeAdapter<LoginLocalStorage> {
  @override
  final int typeId = 0;

  @override
  LoginLocalStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginLocalStorage(
      user: fields[0] as User?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginLocalStorage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginLocalStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
