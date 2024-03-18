// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materiales_tpi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialXtpiAdapter extends TypeAdapter<MaterialXtpi> {
  @override
  final int typeId = 13;

  @override
  MaterialXtpi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialXtpi(
      configTpiMaterialId: fields[0] as int,
      tipoPuntoInspeccionId: fields[1] as int,
      materialId: fields[2] as int,
      codMaterial: fields[3] as String,
      descripcion: fields[4] as String,
      unidad: fields[5] as String,
      dosis: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MaterialXtpi obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.configTpiMaterialId)
      ..writeByte(1)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.materialId)
      ..writeByte(3)
      ..write(obj.codMaterial)
      ..writeByte(4)
      ..write(obj.descripcion)
      ..writeByte(5)
      ..write(obj.unidad)
      ..writeByte(6)
      ..write(obj.dosis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialXtpiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
