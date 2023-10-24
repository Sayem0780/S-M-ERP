// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chassis_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChassisAdapter extends TypeAdapter<Chassis> {
  @override
  final int typeId = 6;

  @override
  Chassis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chassis(
      name: fields[0] as String,
      cc: fields[1] as String,
      chassis: fields[2] as String,
      engineNo: fields[3] as String,
      color: fields[4] as String,
      model: fields[5] as String,
      remark: fields[6] as String,
      buyingPrice: fields[7] as double,
      invoice: fields[8] as double,
      ttAmount: fields[9] as double,
      portCost: fields[10] as double,
      duty: fields[11] as double,
      cnf: fields[12] as double,
      warfrent: fields[13] as double,
      others: fields[14] as double,
      total: fields[15] as double,
      sellingPrice: fields[16] as double,
      profit: fields[17] as double,
      invoiceRate: fields[18] as double,
      invoiceBdt: fields[19] as double,
      ttRate: fields[20] as double,
      ttBdt: fields[21] as double,
      sold: fields[23] as String,
      vat: fields[22] as String,
      delivery_date: fields[24] as String,
      km: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Chassis obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cc)
      ..writeByte(2)
      ..write(obj.chassis)
      ..writeByte(3)
      ..write(obj.engineNo)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.model)
      ..writeByte(6)
      ..write(obj.remark)
      ..writeByte(7)
      ..write(obj.buyingPrice)
      ..writeByte(8)
      ..write(obj.invoice)
      ..writeByte(9)
      ..write(obj.ttAmount)
      ..writeByte(10)
      ..write(obj.portCost)
      ..writeByte(11)
      ..write(obj.duty)
      ..writeByte(12)
      ..write(obj.cnf)
      ..writeByte(13)
      ..write(obj.warfrent)
      ..writeByte(14)
      ..write(obj.others)
      ..writeByte(15)
      ..write(obj.total)
      ..writeByte(16)
      ..write(obj.sellingPrice)
      ..writeByte(17)
      ..write(obj.profit)
      ..writeByte(18)
      ..write(obj.invoiceRate)
      ..writeByte(19)
      ..write(obj.invoiceBdt)
      ..writeByte(20)
      ..write(obj.ttRate)
      ..writeByte(21)
      ..write(obj.ttBdt)
      ..writeByte(22)
      ..write(obj.vat)
      ..writeByte(23)
      ..write(obj.sold)
      ..writeByte(24)
      ..write(obj.delivery_date)
      ..writeByte(25)
      ..write(obj.km);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChassisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
