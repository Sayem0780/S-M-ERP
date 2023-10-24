// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_sale_customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleCustomAdapter extends TypeAdapter<SaleCustom> {
  @override
  final int typeId = 5;

  @override
  SaleCustom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleCustom(
      a: fields[0] as Chassis,
      name: fields[1] as String,
      intro: fields[2] as String,
      price: fields[3] as String,
      address: fields[4] as String,
      phone: fields[5] as String,
      customerPay: fields[6] as String,
      inWord: fields[7] as String,
      balance: fields[8] as String,
      currentDate: fields[9] as dynamic,
      cheque: fields[10] as String,
      bank: fields[11] as String,
      branch: fields[12] as String,
      tyre: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaleCustom obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.balance)
      ..writeByte(9)
      ..write(obj.currentDate)
      ..writeByte(10)
      ..write(obj.cheque)
      ..writeByte(11)
      ..write(obj.bank)
      ..writeByte(12)
      ..write(obj.branch)
      ..writeByte(13)
      ..write(obj.tyre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleCustomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
