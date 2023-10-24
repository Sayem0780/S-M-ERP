// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LCAdapter extends TypeAdapter<LC> {
  @override
  final int typeId = 7;

  @override
  LC read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LC(
      lcNo: fields[0] as String,
      irc: fields[1] as String,
      supplier: fields[2] as String,
      shipment: fields[3] as String,
      chassis: (fields[4] as List).cast<Chassis>(),
      date: fields[5] as String,
      lcAmount: fields[6] as String,
      bank: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, LC obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.lcNo)
      ..writeByte(1)
      ..write(obj.irc)
      ..writeByte(2)
      ..write(obj.supplier)
      ..writeByte(3)
      ..write(obj.shipment)
      ..writeByte(4)
      ..write(obj.chassis)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.lcAmount)
      ..writeByte(7)
      ..write(obj.bank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LCAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
