// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tecnico.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TecnicoAdapter extends TypeAdapter<Tecnico> {
  @override
  final int typeId = 3;

  @override
  Tecnico read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tecnico(
      tecnicoId: fields[0] as int,
      codTecnico: fields[1] as String,
      nombre: fields[2] as String,
      fechaNacimiento: fields[3] as DateTime?,
      documento: fields[4] as String,
      fechaIngreso: fields[5] as DateTime?,
      fechaVtoCarneSalud: fields[6] as DateTime?,
      deshabilitado: fields[7] as bool?,
      cargo: fields[8] as Cargo?,
    );
  }

  @override
  void write(BinaryWriter writer, Tecnico obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.tecnicoId)
      ..writeByte(1)
      ..write(obj.codTecnico)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.fechaNacimiento)
      ..writeByte(4)
      ..write(obj.documento)
      ..writeByte(5)
      ..write(obj.fechaIngreso)
      ..writeByte(6)
      ..write(obj.fechaVtoCarneSalud)
      ..writeByte(7)
      ..write(obj.deshabilitado)
      ..writeByte(8)
      ..write(obj.cargo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TecnicoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
