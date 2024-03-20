// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traslado_nuevo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrasladoNuevoAdapter extends TypeAdapter<TrasladoNuevo> {
  @override
  final int typeId = 35;

  @override
  TrasladoNuevo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrasladoNuevo(
      otPiTrasladoNuevoId: fields[0] as int,
      otPuntoInspeccionId: fields[1] as int,
      codPuntoInspeccion: fields[2] as String,
      codigoBarra: fields[3] as String,
      zona: fields[4] as String,
      sector: fields[5] as String,
      tipoPuntoInspeccionId: fields[6] as int,
      codTipoPuntoInspeccion: fields[7] as String,
      tipoPuntoInspeccion: fields[8] as String,
      plagaObjetivoId: fields[9] as int,
      codPlagaObjetivo: fields[10] as String,
      plagaObjetivo: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrasladoNuevo obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.otPiTrasladoNuevoId)
      ..writeByte(1)
      ..write(obj.otPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.codPuntoInspeccion)
      ..writeByte(3)
      ..write(obj.codigoBarra)
      ..writeByte(4)
      ..write(obj.zona)
      ..writeByte(5)
      ..write(obj.sector)
      ..writeByte(6)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(7)
      ..write(obj.codTipoPuntoInspeccion)
      ..writeByte(8)
      ..write(obj.tipoPuntoInspeccion)
      ..writeByte(9)
      ..write(obj.plagaObjetivoId)
      ..writeByte(10)
      ..write(obj.codPlagaObjetivo)
      ..writeByte(11)
      ..write(obj.plagaObjetivo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrasladoNuevoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
