// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_pto_inspeccion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionPtoInspeccionAdapter extends TypeAdapter<RevisionPtoInspeccion> {
  @override
  final int typeId = 22;

  @override
  RevisionPtoInspeccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionPtoInspeccion(
      otPuntoInspeccionId: fields[0] as int?,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      puntoInspeccionId: fields[3] as int,
      planoId: fields[4] as int,
      tipoPuntoInspeccionId: fields[5] as int,
      codTipoPuntoInspeccion: fields[6] as String,
      descTipoPuntoInspeccion: fields[7] as String,
      plagaObjetivoId: fields[8] as int,
      codPuntoInspeccion: fields[9] as String,
      codigoBarra: fields[10] as String,
      zona: fields[11] as String,
      sector: fields[12] as String,
      piAccionId: fields[13] as int?,
      codAccion: fields[14] as String?,
      descPiAccion: fields[15] as String?,
      comentario: fields[16] as String,
      materiales: (fields[17] as List).cast<PtoMaterial>(),
      plagas: (fields[18] as List).cast<PtoPlaga>(),
      tareas: (fields[19] as List).cast<PtoTarea>(),
      trasladoNuevo: (fields[20] as List).cast<TrasladoNuevo>(),
      idPIAccion: fields[21] as int,
      seleccionado: fields[22] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RevisionPtoInspeccion obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.otPuntoInspeccionId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.puntoInspeccionId)
      ..writeByte(4)
      ..write(obj.planoId)
      ..writeByte(5)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(6)
      ..write(obj.codTipoPuntoInspeccion)
      ..writeByte(7)
      ..write(obj.descTipoPuntoInspeccion)
      ..writeByte(8)
      ..write(obj.plagaObjetivoId)
      ..writeByte(9)
      ..write(obj.codPuntoInspeccion)
      ..writeByte(10)
      ..write(obj.codigoBarra)
      ..writeByte(11)
      ..write(obj.zona)
      ..writeByte(12)
      ..write(obj.sector)
      ..writeByte(13)
      ..write(obj.piAccionId)
      ..writeByte(14)
      ..write(obj.codAccion)
      ..writeByte(15)
      ..write(obj.descPiAccion)
      ..writeByte(16)
      ..write(obj.comentario)
      ..writeByte(17)
      ..write(obj.materiales)
      ..writeByte(18)
      ..write(obj.plagas)
      ..writeByte(19)
      ..write(obj.tareas)
      ..writeByte(20)
      ..write(obj.trasladoNuevo)
      ..writeByte(21)
      ..write(obj.idPIAccion)
      ..writeByte(22)
      ..write(obj.seleccionado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionPtoInspeccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
