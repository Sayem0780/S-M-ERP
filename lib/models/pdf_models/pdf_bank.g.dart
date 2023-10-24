// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_bank.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankAdapter extends TypeAdapter<Bank> {
  @override
  final int typeId = 0;

  @override
  Bank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bank(
      a: fields[0] as Chassis,
      intro: fields[1] as String,
      ac: fields[2] as String,
      price: fields[3] as String,
      bank: fields[4] as String,
      branch: fields[5] as String,
      bankPay: fields[6] as String,
      po: fields[7] as String,
      inWord: fields[8] as String,
      bacode: fields[9] as String,
      currentDate: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Bank obj) {
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
      ..write(obj.branch)
      ..writeByte(6)
      ..write(obj.bankPay)
      ..writeByte(7)
      ..write(obj.po)
      ..writeByte(8)
      ..write(obj.inWord)
      ..writeByte(9)
      ..write(obj.bacode)
      ..writeByte(10)
      ..write(obj.currentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
