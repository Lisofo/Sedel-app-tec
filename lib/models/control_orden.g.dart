// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_orden.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ControlOrdenAdapter extends TypeAdapter<ControlOrden> {
  @override
  final int typeId = 8;

  @override
  ControlOrden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ControlOrden(
      controlRegId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      controlId: fields[2] as int,
      ordinal: fields[3] as int,
      respuesta: fields[4] as String,
      comentario: fields[5] as String,
      grupo: fields[6] as String,
      pregunta: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ControlOrden obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.controlRegId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.controlId)
      ..writeByte(3)
      ..write(obj.ordinal)
      ..writeByte(4)
      ..write(obj.respuesta)
      ..writeByte(5)
      ..write(obj.comentario)
      ..writeByte(6)
      ..write(obj.grupo)
      ..writeByte(7)
      ..write(obj.pregunta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControlOrdenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
