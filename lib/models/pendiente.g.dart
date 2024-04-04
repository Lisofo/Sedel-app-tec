// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendiente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendienteAdapter extends TypeAdapter<Pendiente> {
  @override
  final int typeId = 40;

  @override
  Pendiente read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pendiente(
      pendienteDelete: (fields[0] as List).cast<PendienteDelete>(),
      pendientePost: (fields[1] as List).cast<PendientePost>(),
      pendientePut: (fields[2] as List).cast<PendientePut>(),
      ordenId: fields[3] as int,
      otRevisionId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pendiente obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.pendienteDelete)
      ..writeByte(1)
      ..write(obj.pendientePost)
      ..writeByte(2)
      ..write(obj.pendientePut)
      ..writeByte(3)
      ..write(obj.ordenId)
      ..writeByte(4)
      ..write(obj.otRevisionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendienteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
