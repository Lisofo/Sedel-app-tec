// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cargo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CargoAdapter extends TypeAdapter<Cargo> {
  @override
  final int typeId = 6;

  @override
  Cargo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cargo(
      cargoId: fields[0] as int,
      codCargo: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cargo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cargoId)
      ..writeByte(1)
      ..write(obj.codCargo)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CargoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
