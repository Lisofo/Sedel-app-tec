// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_materiales.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionMaterialAdapter extends TypeAdapter<RevisionMaterial> {
  @override
  final int typeId = 20;

  @override
  RevisionMaterial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionMaterial(
      otMaterialId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      cantidad: fields[3] as double,
      comentario: fields[4] as String,
      ubicacion: fields[5] as String,
      areaCobertura: fields[6] as String,
      plagas: (fields[7] as List).cast<Plaga>(),
      material: fields[8] as Materiales,
      lote: fields[9] as Lote,
      metodoAplicacion: fields[10] as MetodoAplicacion,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionMaterial obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.otMaterialId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.cantidad)
      ..writeByte(4)
      ..write(obj.comentario)
      ..writeByte(5)
      ..write(obj.ubicacion)
      ..writeByte(6)
      ..write(obj.areaCobertura)
      ..writeByte(7)
      ..write(obj.plagas)
      ..writeByte(8)
      ..write(obj.material)
      ..writeByte(9)
      ..write(obj.lote)
      ..writeByte(10)
      ..write(obj.metodoAplicacion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionMaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
