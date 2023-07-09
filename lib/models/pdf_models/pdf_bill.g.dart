// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 3;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      a: fields[0] as Chassis,
      intro: fields[1] as String,
      ac: fields[2] as String,
      price: fields[3] as String,
      bank: fields[4] as String,
      bankPay: fields[5] as String,
      customer: fields[6] as String,
      total: fields[7] as String,
      inWord: fields[8] as String,
      bcode: fields[9] as String,
      currentDate: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.intro)
      ..writeByte(2)
      ..write(obj.ac)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.bank)
      ..writeByte(5)
      ..write(obj.bankPay)
      ..writeByte(6)
      ..write(obj.customer)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.inWord)
      ..writeByte(9)
      ..write(obj.bcode)
      ..writeByte(10)
      ..write(obj.currentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
