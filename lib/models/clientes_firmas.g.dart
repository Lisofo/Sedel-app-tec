// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientes_firmas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteFirmaAdapter extends TypeAdapter<ClienteFirma> {
  @override
  final int typeId = 7;

  @override
  ClienteFirma read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClienteFirma(
      otFirmaId: fields[0] as int,
      ordenTrabajoId: fields[1] as int,
      otRevisionId: fields[2] as int,
      nombre: fields[3] as String,
      area: fields[4] as String,
      firmaPath: fields[5] as String,
      firmaMd5: fields[6] as String,
      comentario: fields[7] as String,
      firma: fields[8] as Uint8List?,
      hiveKey: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ClienteFirma obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.otFirmaId)
      ..writeByte(1)
      ..write(obj.ordenTrabajoId)
      ..writeByte(2)
      ..write(obj.otRevisionId)
      ..writeByte(3)
      ..write(obj.nombre)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.firmaPath)
      ..writeByte(6)
      ..write(obj.firmaMd5)
      ..writeByte(7)
      ..write(obj.comentario)
      ..writeByte(8)
      ..write(obj.firma)
      ..writeByte(9)
      ..write(obj.hiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClienteFirmaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
