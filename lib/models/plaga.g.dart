// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plaga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlagaAdapter extends TypeAdapter<Plaga> {
  @override
  final int typeId = 16;

  @override
  Plaga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plaga(
      plagaId: fields[0] as int,
      codPlaga: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Plaga obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.plagaId)
      ..writeByte(1)
      ..write(obj.codPlaga)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlagaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
