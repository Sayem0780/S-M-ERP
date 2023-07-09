import 'package:hive/hive.dart';
part 'chassis_model.g.dart';
@HiveType(typeId: 0)
class Chassis extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String cc;
  @HiveField(2)
  String chassis;
  @HiveField(3)
  String engineNo;
  @HiveField(4)
  String color;
  @HiveField(5)
  String model;
  @HiveField(6)
  String remark;
  @HiveField(7)
  double buyingPrice;
  @HiveField(8)
  double invoice;
  @HiveField(9)
  double ttAmount;
  @HiveField(10)
  double portCost;
  @HiveField(11)
  double duty;
  @HiveField(12)
  double cnf;
  @HiveField(13)
  double warfrent;
  @HiveField(14)
  double others;
  @HiveField(15)
  double total;
  @HiveField(16)
  double sellingPrice;
  @HiveField(17)
  double profit;
  @HiveField(18)
  double invoiceRate;
  @HiveField(19)
  double invoiceBdt;
  @HiveField(20)
  double ttRate;
  @HiveField(21)
  double ttBdt;
  @HiveField(22)
  String vat;
  @HiveField(23)
  String sold;
  @HiveField(24)
  String delivery_date;
  @HiveField(25)
  String km;
  Chassis({
    required this.name,
    required this.cc,
    required this.chassis,
    required this.engineNo,
    required this.color,
    required this.model,
    required this.remark,
    required this.buyingPrice,
    required this.invoice,
    required this.ttAmount,
    required this.portCost,
    required this.duty,
    required this.cnf,
    required this.warfrent,
    required this.others,
    required this.total,
    required this.sellingPrice,
    required this.profit,
    required this.invoiceRate,
    required this.invoiceBdt,
    required this.ttRate,
    required this.ttBdt,
    required this.sold,
    required this.vat,
    required this.delivery_date,
    required this.km,
  });

}
