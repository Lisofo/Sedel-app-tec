// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  final int typeId = 2;

  @override
  Cliente read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cliente(
      clienteId: fields[0] as int,
      codCliente: fields[1] as String,
      nombre: fields[2] as String,
      nombreFantasia: fields[3] as String,
      direccion: fields[4] as String,
      barrio: fields[5] as String,
      localidad: fields[6] as String,
      telefono1: fields[7] as String,
      telefono2: fields[8] as String,
      email: fields[9] as String,
      ruc: fields[10] as String,
      estado: fields[11] as String,
      coordenadas: fields[12] as dynamic,
      tecnico: fields[13] as Tecnico,
      departamento: fields[14] as Departamento,
      tipoCliente: fields[15] as TipoCliente,
      notas: fields[19] as String,
    )
      ..departamentoId = fields[16] as dynamic
      ..tipoClienteId = fields[17] as dynamic
      ..tecnicoId = fields[18] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Cliente obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.clienteId)
      ..writeByte(1)
      ..write(obj.codCliente)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.nombreFantasia)
      ..writeByte(4)
      ..write(obj.direccion)
      ..writeByte(5)
      ..write(obj.barrio)
      ..writeByte(6)
      ..write(obj.localidad)
      ..writeByte(7)
      ..write(obj.telefono1)
      ..writeByte(8)
      ..write(obj.telefono2)
      ..writeByte(9)
      ..write(obj.email)
      ..writeByte(10)
      ..write(obj.ruc)
      ..writeByte(11)
      ..write(obj.estado)
      ..writeByte(12)
      ..write(obj.coordenadas)
      ..writeByte(13)
      ..write(obj.tecnico)
      ..writeByte(14)
      ..write(obj.departamento)
      ..writeByte(15)
      ..write(obj.tipoCliente)
      ..writeByte(16)
      ..write(obj.departamentoId)
      ..writeByte(17)
      ..write(obj.tipoClienteId)
      ..writeByte(18)
      ..write(obj.tecnicoId)
      ..writeByte(19)
      ..write(obj.notas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClienteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
