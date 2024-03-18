// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicio_ordenes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServicioOrdenesAdapter extends TypeAdapter<ServicioOrdenes> {
  @override
  final int typeId = 4;

  @override
  ServicioOrdenes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServicioOrdenes(
      servicioId: fields[0] as int,
      codServicio: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServicioOrdenes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.servicioId)
      ..writeByte(1)
      ..write(obj.codServicio)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicioOrdenesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
