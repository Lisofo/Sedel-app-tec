// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metodo_aplicacion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetodoAplicacionAdapter extends TypeAdapter<MetodoAplicacion> {
  @override
  final int typeId = 30;

  @override
  MetodoAplicacion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetodoAplicacion(
      metodoAplicacionId: fields[0] as int,
      codMetodoAplicacion: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MetodoAplicacion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.metodoAplicacionId)
      ..writeByte(1)
      ..write(obj.codMetodoAplicacion)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetodoAplicacionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
