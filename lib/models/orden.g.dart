// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orden.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdenAdapter extends TypeAdapter<Orden> {
  @override
  final int typeId = 0;

  @override
  Orden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Orden(
      ordenTrabajoId: fields[0] as int,
      fechaOrdenTrabajo: fields[1] as DateTime,
      fechaDesde: fields[2] as DateTime,
      fechaHasta: fields[3] as DateTime,
      instrucciones: fields[4] as String,
      comentarios: fields[5] as dynamic,
      estado: fields[6] as String,
      tipoOrden: fields[7] as TipoOrden,
      cliente: fields[8] as Cliente,
      tecnico: fields[9] as Tecnico,
      servicio: (fields[10] as List).cast<ServicioOrdenes>(),
      otRevisionId: fields[11] as int,
      planoId: fields[12] as int,
      revision: fields[13] as Revision?,
    );
  }

  @override
  void write(BinaryWriter writer, Orden obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.ordenTrabajoId)
      ..writeByte(1)
      ..write(obj.fechaOrdenTrabajo)
      ..writeByte(2)
      ..write(obj.fechaDesde)
      ..writeByte(3)
      ..write(obj.fechaHasta)
      ..writeByte(4)
      ..write(obj.instrucciones)
      ..writeByte(5)
      ..write(obj.comentarios)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.tipoOrden)
      ..writeByte(8)
      ..write(obj.cliente)
      ..writeByte(9)
      ..write(obj.tecnico)
      ..writeByte(10)
      ..write(obj.servicio)
      ..writeByte(11)
      ..write(obj.otRevisionId)
      ..writeByte(12)
      ..write(obj.planoId)
      ..writeByte(13)
      ..write(obj.revision);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
