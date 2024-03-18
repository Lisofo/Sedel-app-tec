// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipos_ptos_inspeccion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipoPtosInspeccionAdapter extends TypeAdapter<TipoPtosInspeccion> {
  @override
  final int typeId = 27;

  @override
  TipoPtosInspeccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TipoPtosInspeccion(
      tipoPuntoInspeccionId: fields[0] as int,
      codTipoPuntoInspeccion: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TipoPtosInspeccion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(1)
      ..write(obj.codTipoPuntoInspeccion)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoPtosInspeccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
