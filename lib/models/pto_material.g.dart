// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pto_material.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtoMaterialAdapter extends TypeAdapter<PtoMaterial> {
  @override
  final int typeId = 32;

  @override
  PtoMaterial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtoMaterial(
      otPiMaterialId: fields[0] as int,
      otPuntoInspeccionId: fields[1] as int,
      materialId: fields[2] as int,
      codMaterial: fields[3] as String,
      descripcion: fields[4] as String,
      dosis: fields[5] as String,
      unidad: fields[6] as String,
      cantidad: fields[7] as int,
      materialLoteId: fields[8] as int?,
      lote: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PtoMaterial obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.otPiMaterialId)
      ..writeByte(1)
      ..write(obj.otPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.materialId)
      ..writeByte(3)
      ..write(obj.codMaterial)
      ..writeByte(4)
      ..write(obj.descripcion)
      ..writeByte(5)
      ..write(obj.dosis)
      ..writeByte(6)
      ..write(obj.unidad)
      ..writeByte(7)
      ..write(obj.cantidad)
      ..writeByte(8)
      ..write(obj.materialLoteId)
      ..writeByte(9)
      ..write(obj.lote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtoMaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
