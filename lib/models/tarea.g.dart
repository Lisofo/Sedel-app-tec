// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarea.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TareaAdapter extends TypeAdapter<Tarea> {
  @override
  final int typeId = 24;

  @override
  Tarea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tarea(
      tareaId: fields[0] as int,
      codTarea: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tarea obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tareaId)
      ..writeByte(1)
      ..write(obj.codTarea)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TareaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
