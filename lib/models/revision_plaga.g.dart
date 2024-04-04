// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_plaga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionPlagaAdapter extends TypeAdapter<RevisionPlaga> {
  @override
  final int typeId = 21;

  @override
  RevisionPlaga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionPlaga(
      otPlagaId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      comentario: fields[3] as String,
      plagaId: fields[4] as int,
      codPlaga: fields[5] as String,
      plaga: fields[6] as String,
      gradoInfestacionId: fields[7] as int,
      codGradoInfestacion: fields[8] as String,
      gradoInfestacion: fields[9] as String,
      hiveKey: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionPlaga obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.otPlagaId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.comentario)
      ..writeByte(4)
      ..write(obj.plagaId)
      ..writeByte(5)
      ..write(obj.codPlaga)
      ..writeByte(6)
      ..write(obj.plaga)
      ..writeByte(7)
      ..write(obj.gradoInfestacionId)
      ..writeByte(8)
      ..write(obj.codGradoInfestacion)
      ..writeByte(9)
      ..write(obj.gradoInfestacion)
      ..writeByte(10)
      ..write(obj.hiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionPlagaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
