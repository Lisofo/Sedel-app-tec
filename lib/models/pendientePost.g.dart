// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendientePost.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendientePostAdapter extends TypeAdapter<PendientePost> {
  @override
  final int typeId = 39;

  @override
  PendientePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendientePost(
      materiales: (fields[0] as List).cast<RevisionMaterial>(),
      tareas: (fields[1] as List).cast<RevisionTarea>(),
      plagas: (fields[2] as List).cast<RevisionPlaga>(),
      obsevacion: (fields[3] as List).cast<Observacion>(),
      firma: (fields[4] as List).cast<ClienteFirma>(),
    );
  }

  @override
  void write(BinaryWriter writer, PendientePost obj) {
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
      other is PendientePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
