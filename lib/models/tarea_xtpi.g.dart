// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarea_xtpi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TareaXtpiAdapter extends TypeAdapter<TareaXtpi> {
  @override
  final int typeId = 25;

  @override
  TareaXtpi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TareaXtpi(
      configTpiTareaId: fields[0] as int,
      tipoPuntoInspeccionId: fields[1] as int,
      modo: fields[2] as String,
      tareaId: fields[3] as int,
      codTarea: fields[4] as String,
      descripcion: fields[5] as String,
      selected: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TareaXtpi obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.configTpiTareaId)
      ..writeByte(1)
      ..write(obj.tipoPuntoInspeccionId)
      ..writeByte(2)
      ..write(obj.modo)
      ..writeByte(3)
      ..write(obj.tareaId)
      ..writeByte(4)
      ..write(obj.codTarea)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TareaXtpiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
