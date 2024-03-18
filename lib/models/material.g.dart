// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialesAdapter extends TypeAdapter<Materiales> {
  @override
  final int typeId = 5;

  @override
  Materiales read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Materiales(
      materialId: fields[0] as int,
      codMaterial: fields[1] as String,
      descripcion: fields[2] as String,
      dosis: fields[3] as String,
      unidad: fields[4] as String,
      fabProv: fields[5] as String,
      enAppTecnico: fields[6] as String,
      enUso: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Materiales obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.materialId)
      ..writeByte(1)
      ..write(obj.codMaterial)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.dosis)
      ..writeByte(4)
      ..write(obj.unidad)
      ..writeByte(5)
      ..write(obj.fabProv)
      ..writeByte(6)
      ..write(obj.enAppTecnico)
      ..writeByte(7)
      ..write(obj.enUso);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
