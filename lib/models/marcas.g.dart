// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marcas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarcaAdapter extends TypeAdapter<Marca> {
  @override
  final int typeId = 12;

  @override
  Marca read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Marca(
      marcaId: fields[0] as int,
      desde: fields[1] as DateTime,
      hasta: fields[2] as DateTime?,
      tecnicoId: fields[3] as int,
      codTecnico: fields[4] as String,
      nombreTecnico: fields[5] as String,
      ubicacionId: fields[6] as int?,
      ubicacion: fields[7] as String?,
      ubicacionIdHasta: fields[8] as int?,
      ubicacionHasta: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Marca obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.marcaId)
      ..writeByte(1)
      ..write(obj.desde)
      ..writeByte(2)
      ..write(obj.hasta)
      ..writeByte(3)
      ..write(obj.tecnicoId)
      ..writeByte(4)
      ..write(obj.codTecnico)
      ..writeByte(5)
      ..write(obj.nombreTecnico)
      ..writeByte(6)
      ..write(obj.ubicacionId)
      ..writeByte(7)
      ..write(obj.ubicacion)
      ..writeByte(8)
      ..write(obj.ubicacionIdHasta)
      ..writeByte(9)
      ..write(obj.ubicacionHasta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarcaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
