// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_cutomer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomAdapter extends TypeAdapter<Custom> {
  @override
  final int typeId = 3;

  @override
  Custom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Custom(
      a: fields[0] as Chassis,
      name: fields[1] as String,
      intro: fields[2] as String,
      price: fields[3] as String,
      address: fields[4] as String,
      phone: fields[5] as String,
      customerPay: fields[6] as String,
      inWord: fields[7] as String,
      cocode: fields[8] as String,
      currentDate: fields[9] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Custom obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.intro)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.customerPay)
      ..writeByte(7)
      ..write(obj.inWord)
      ..writeByte(8)
      ..write(obj.cocode)
      ..writeByte(9)
      ..write(obj.currentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
