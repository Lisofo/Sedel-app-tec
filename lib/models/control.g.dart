// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ControlAdapter extends TypeAdapter<Control> {
  @override
  final int typeId = 9;

  @override
  Control read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Control(
      controlId: fields[0] as int,
      grupo: fields[1] as String,
      pregunta: fields[2] as String,
      comentario: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Control obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.controlId)
      ..writeByte(1)
      ..write(obj.grupo)
      ..writeByte(2)
      ..write(obj.pregunta)
      ..writeByte(3)
      ..write(obj.comentario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
