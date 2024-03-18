// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_tarea.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionTareaAdapter extends TypeAdapter<RevisionTarea> {
  @override
  final int typeId = 23;

  @override
  RevisionTarea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionTarea(
      otTareaId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      tareaId: fields[3] as int,
      codTarea: fields[4] as String,
      descripcion: fields[5] as String,
      comentario: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionTarea obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.otTareaId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.tareaId)
      ..writeByte(4)
      ..write(obj.codTarea)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.comentario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionTareaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
