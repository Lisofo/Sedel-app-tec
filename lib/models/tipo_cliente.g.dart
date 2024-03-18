// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_cliente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipoClienteAdapter extends TypeAdapter<TipoCliente> {
  @override
  final int typeId = 26;

  @override
  TipoCliente read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TipoCliente(
      tipoClienteId: fields[0] as int,
      codTipoCliente: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TipoCliente obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tipoClienteId)
      ..writeByte(1)
      ..write(obj.codTipoCliente)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoClienteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
