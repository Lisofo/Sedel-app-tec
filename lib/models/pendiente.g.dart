// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendiente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendienteAdapter extends TypeAdapter<Pendiente> {
  @override
  final int typeId = 37;

  @override
  Pendiente read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pendiente(
      ordenId: fields[0] as int?,
      otRevisionId: fields[1] as int?,
      listaPendientes: (fields[2] as List).cast<dynamic>(),
      accion: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pendiente obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ordenId)
      ..writeByte(1)
      ..write(obj.otRevisionId)
      ..writeByte(2)
      ..write(obj.listaPendientes)
      ..writeByte(3)
      ..write(obj.accion);
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
