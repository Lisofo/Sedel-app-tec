// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_firmas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionFirmasAdapter extends TypeAdapter<RevisionFirmas> {
  @override
  final int typeId = 19;

  @override
  RevisionFirmas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionFirmas(
      otFirmaId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      nombre: fields[3] as String,
      area: fields[4] as String,
      firmaPath: fields[5] as String,
      firmaMd5: fields[6] as String,
      comentario: fields[7] as String,
      hiveKey: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionFirmas obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.otFirmaId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.nombre)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.firmaPath)
      ..writeByte(6)
      ..write(obj.firmaMd5)
      ..writeByte(7)
      ..write(obj.comentario)
      ..writeByte(8)
      ..write(obj.hiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionFirmasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
