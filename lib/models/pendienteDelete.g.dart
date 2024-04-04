// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendienteDelete.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendienteDeleteAdapter extends TypeAdapter<PendienteDelete> {
  @override
  final int typeId = 37;

  @override
  PendienteDelete read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendienteDelete(
      materiales: (fields[0] as List).cast<int>(),
      tareas: (fields[1] as List).cast<int>(),
      plagas: (fields[2] as List).cast<int>(),
      obsevacion: (fields[3] as List).cast<int>(),
      firma: (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PendienteDelete obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.materiales)
      ..writeByte(1)
      ..write(obj.tareas)
      ..writeByte(2)
      ..write(obj.plagas)
      ..writeByte(3)
      ..write(obj.obsevacion)
      ..writeByte(4)
      ..write(obj.firma);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendienteDeleteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
