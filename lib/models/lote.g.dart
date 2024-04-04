// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoteAdapter extends TypeAdapter<Lote> {
  @override
  final int typeId = 29;

  @override
  Lote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lote(
      materialLoteId: fields[0] as int,
      lote: fields[1] as String,
      estado: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Lote obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.materialLoteId)
      ..writeByte(1)
      ..write(obj.lote)
      ..writeByte(2)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
