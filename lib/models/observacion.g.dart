// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observacion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObservacionAdapter extends TypeAdapter<Observacion> {
  @override
  final int typeId = 14;

  @override
  Observacion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Observacion(
      otObservacionId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      observacion: fields[3] as String,
      obsRestringida: fields[4] as String,
      comentarioInterno: fields[5] as String,
      hiveKey: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Observacion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.otObservacionId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.observacion)
      ..writeByte(4)
      ..write(obj.obsRestringida)
      ..writeByte(5)
      ..write(obj.comentarioInterno)
      ..writeByte(6)
      ..write(obj.hiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObservacionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
