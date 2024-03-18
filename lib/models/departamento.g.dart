// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartamentoAdapter extends TypeAdapter<Departamento> {
  @override
  final int typeId = 10;

  @override
  Departamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Departamento(
      departamentoId: fields[0] as int?,
      codDepartamento: fields[1] as String,
      nombre: fields[2] as String,
      zonaId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Departamento obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.departamentoId)
      ..writeByte(1)
      ..write(obj.codDepartamento)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.zonaId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
