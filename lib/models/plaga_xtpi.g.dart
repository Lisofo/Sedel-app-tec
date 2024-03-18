// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaga_xtpi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlagaXtpiAdapter extends TypeAdapter<PlagaXtpi> {
  @override
  final int typeId = 17;

  @override
  PlagaXtpi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlagaXtpi(
      configTpiPlagaId: fields[0] as int,
      tipoPuntoInspeccionId: fields[1] as int,
      plagaId: fields[2] as int,
      codPlaga: fields[3] as String,
      descripcion: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlagaXtpi obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.configTpiPlagaId)
      ..writeByte(1)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.plagaId)
      ..writeByte(3)
      ..write(obj.codPlaga)
      ..writeByte(4)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlagaXtpiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
