// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaga_objetivo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlagaObjetivoAdapter extends TypeAdapter<PlagaObjetivo> {
  @override
  final int typeId = 15;

  @override
  PlagaObjetivo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlagaObjetivo(
      plagaObjetivoId: fields[0] as int,
      codPlagaObjetivo: fields[1] as String,
      descripcion: fields[2] as String,
      fechaBaja: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PlagaObjetivo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.plagaObjetivoId)
      ..writeByte(1)
      ..write(obj.codPlagaObjetivo)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.fechaBaja);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlagaObjetivoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
