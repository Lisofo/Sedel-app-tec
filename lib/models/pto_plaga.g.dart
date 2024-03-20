// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pto_plaga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtoPlagaAdapter extends TypeAdapter<PtoPlaga> {
  @override
  final int typeId = 33;

  @override
  PtoPlaga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtoPlaga(
      otPiPlagaId: fields[0] as int,
      otPuntoInspeccionId: fields[1] as int,
      plagaId: fields[2] as int,
      codPlaga: fields[3] as String,
      descPlaga: fields[4] as String,
      cantidad: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PtoPlaga obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.otPiPlagaId)
      ..writeByte(1)
      ..write(obj.otPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.plagaId)
      ..writeByte(3)
      ..write(obj.codPlaga)
      ..writeByte(4)
      ..write(obj.descPlaga)
      ..writeByte(5)
      ..write(obj.cantidad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtoPlagaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
