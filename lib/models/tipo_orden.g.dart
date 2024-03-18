// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_orden.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipoOrdenAdapter extends TypeAdapter<TipoOrden> {
  @override
  final int typeId = 1;

  @override
  TipoOrden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TipoOrden(
      tipoOrdenId: fields[0] as int,
      codTipoOrden: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TipoOrden obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tipoOrdenId)
      ..writeByte(1)
      ..write(obj.codTipoOrden)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoOrdenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
