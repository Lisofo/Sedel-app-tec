// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionAdapter extends TypeAdapter<Revision> {
  @override
  final int typeId = 31;

  @override
  Revision read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Revision(
      otRevisionId: fields[0] as int,
      otOrdenId: fields[1] as int,
      revisionPlaga: (fields[2] as List).cast<RevisionPlaga>(),
      revisionMaterial: (fields[3] as List).cast<RevisionMaterial>(),
      revisionFirma: (fields[4] as List).cast<RevisionFirmas>(),
      revisionPtoInspeccion: (fields[5] as List).cast<RevisionPtoInspeccion>(),
      revisionTarea: (fields[6] as List).cast<RevisionTarea>(),
      revisionObservacion: (fields[7] as List).cast<Observacion>(),
    );
  }

  @override
  void write(BinaryWriter writer, Revision obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.otRevisionId)
      ..writeByte(1)
      ..write(obj.otOrdenId)
      ..writeByte(2)
      ..write(obj.revisionPlaga)
      ..writeByte(3)
      ..write(obj.revisionMaterial)
      ..writeByte(4)
      ..write(obj.revisionFirma)
      ..writeByte(5)
      ..write(obj.revisionPtoInspeccion)
      ..writeByte(6)
      ..write(obj.revisionTarea)
      ..writeByte(7)
      ..write(obj.revisionObservacion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
