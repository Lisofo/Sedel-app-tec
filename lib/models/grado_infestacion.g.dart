// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grado_infestacion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradoInfestacionAdapter extends TypeAdapter<GradoInfestacion> {
  @override
  final int typeId = 11;

  @override
  GradoInfestacion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradoInfestacion(
      gradoInfestacionId: fields[0] as int,
      codGradoInfestacion: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GradoInfestacion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gradoInfestacionId)
      ..writeByte(1)
      ..write(obj.codGradoInfestacion)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradoInfestacionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
