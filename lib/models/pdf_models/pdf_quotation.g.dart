// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_quotation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotationAdapter extends TypeAdapter<Quotation> {
  @override
  final int typeId = 5;

  @override
  Quotation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quotation(
      a: fields[0] as Chassis,
      intro: fields[1] as String,
      ac: fields[2] as String,
      fittings: fields[3] as String,
      validity: fields[4] as String,
      price: fields[5] as String,
      payment_method: fields[6] as String,
      qcode: fields[7] as String,
      currentDate: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Quotation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.intro)
      ..writeByte(2)
      ..write(obj.ac)
      ..writeByte(3)
      ..write(obj.fittings)
      ..writeByte(4)
      ..write(obj.validity)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.payment_method)
      ..writeByte(7)
      ..write(obj.qcode)
      ..writeByte(8)
      ..write(obj.currentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
