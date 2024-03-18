// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ptos_inspeccion_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PtosInspeccionAdapter extends TypeAdapter<PtosInspeccion> {
  @override
  final int typeId = 18;

  @override
  PtosInspeccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PtosInspeccion(
      puntoInspeccionId: fields[0] as int,
      planoId: fields[1] as int,
      codPuntoInspeccion: fields[2] as String,
      zona: fields[3] as String,
      sector: fields[4] as String,
      codigoBarra: fields[5] as String,
      tipoPuntoInspeccionId: fields[6] as int,
      codTipoPuntoInspeccion: fields[7] as String,
      descTipoPunto: fields[8] as String,
      plagaObjetivoId: fields[9] as int,
      codPlagaObjetivo: fields[10] as String,
      descPlagaObjetivo: fields[11] as String,
      desde: fields[12] as DateTime,
      estado: fields[13] as String,
      subEstado: fields[14] as String,
      comentario: fields[15] as String,
      seleccionado: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PtosInspeccion obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.puntoInspeccionId)
      ..writeByte(1)
      ..write(obj.planoId)
      ..writeByte(2)
      ..write(obj.codPuntoInspeccion)
      ..writeByte(3)
      ..write(obj.zona)
      ..writeByte(4)
      ..write(obj.sector)
      ..writeByte(5)
      ..write(obj.codigoBarra)
      ..writeByte(6)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(7)
      ..write(obj.codTipoPuntoInspeccion)
      ..writeByte(8)
      ..write(obj.descTipoPunto)
      ..writeByte(9)
      ..write(obj.plagaObjetivoId)
      ..writeByte(10)
      ..write(obj.codPlagaObjetivo)
      ..writeByte(11)
      ..write(obj.descPlagaObjetivo)
      ..writeByte(12)
      ..write(obj.desde)
      ..writeByte(13)
      ..write(obj.estado)
      ..writeByte(14)
      ..write(obj.subEstado)
      ..writeByte(15)
      ..write(obj.comentario)
      ..writeByte(16)
      ..write(obj.seleccionado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PtosInspeccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
