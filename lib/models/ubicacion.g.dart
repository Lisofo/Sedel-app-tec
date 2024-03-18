// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ubicacion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UbicacionAdapter extends TypeAdapter<Ubicacion> {
  @override
  final int typeId = 28;

  @override
  Ubicacion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ubicacion(
      ubicacionId: fields[0] as int,
      fecha: fields[1] as DateTime,
      ubicacion: fields[2] as String,
      usuarioId: fields[3] as int,
      login: fields[4] as String,
      nombre: fields[5] as String,
      apellido: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Ubicacion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.ubicacionId)
      ..writeByte(1)
      ..write(obj.fecha)
      ..writeByte(2)
      ..write(obj.ubicacion)
      ..writeByte(3)
      ..write(obj.usuarioId)
      ..writeByte(4)
      ..write(obj.login)
      ..writeByte(5)
      ..write(obj.nombre)
      ..writeByte(6)
      ..write(obj.apellido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UbicacionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
