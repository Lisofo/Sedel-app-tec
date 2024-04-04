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
      ordenId: fields[0] as int,
      otRevisionId: fields[1] as int,
      materiales: (fields[2] as List).cast<int>(),
      tareas: (fields[3] as List).cast<int>(),
      plagas: (fields[4] as List).cast<int>(),
      obsevacion: (fields[5] as List).cast<int>(),
      firma: (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PendienteDelete obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.ordenId)
      ..writeByte(1)
      ..write(obj.otRevisionId)
      ..writeByte(2)
      ..write(obj.materiales)
      ..writeByte(3)
      ..write(obj.tareas)
      ..writeByte(4)
      ..write(obj.plagas)
      ..writeByte(5)
      ..write(obj.obsevacion)
      ..writeByte(6)
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
