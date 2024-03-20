// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pto_accion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtoAccionAdapter extends TypeAdapter<PtoAccion> {
  @override
  final int typeId = 36;

  @override
  PtoAccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtoAccion(
      piAccionId: fields[0] as int,
      codAccion: fields[1] as String,
      descPiAccion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PtoAccion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.piAccionId)
      ..writeByte(1)
      ..write(obj.codAccion)
      ..writeByte(2)
      ..write(obj.descPiAccion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtoAccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
