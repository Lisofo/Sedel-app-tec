// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pto_tarea.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtoTareaAdapter extends TypeAdapter<PtoTarea> {
  @override
  final int typeId = 34;

  @override
  PtoTarea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtoTarea(
      otPiTareaId: fields[0] as int,
      otPuntoInspeccionId: fields[1] as int,
      tareaId: fields[2] as int,
      codTarea: fields[3] as String,
      descTarea: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PtoTarea obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.otPiTareaId)
      ..writeByte(1)
      ..write(obj.otPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.tareaId)
      ..writeByte(3)
      ..write(obj.codTarea)
      ..writeByte(4)
      ..write(obj.descTarea);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtoTareaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
