// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_challan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallanAdapter extends TypeAdapter<Challan> {
  @override
  final int typeId = 5;

  @override
  Challan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Challan(
      a: fields[0] as Chassis,
      intro: fields[1] as String,
      ac: fields[2] as String,
      tyre: fields[3] as String,
      ccode: fields[4] as String,
      currentDate: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Challan obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.intro)
      ..writeByte(2)
      ..write(obj.ac)
      ..writeByte(3)
      ..write(obj.tyre)
      ..writeByte(4)
      ..write(obj.ccode)
      ..writeByte(5)
      ..write(obj.currentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
