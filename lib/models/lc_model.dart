import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part'lc_model.g.dart';
@HiveType(typeId: 8)
class LC extends HiveObject{
  @HiveField(0)
  String lcNo;
  @HiveField(1)
  String irc;
  @HiveField(2)
  String supplier;
  @HiveField(3)
  String shipment;
  @HiveField(4)
  List<Chassis> chassis;
  @HiveField(5)
  String date;
  @HiveField(06)
  String lcAmount;
  @HiveField(07)
  String bank;
  @HiveField(08)
  String profit;
  LC({
  required this.lcNo,
  required this.irc,
  required this.supplier,
  required this.shipment,
  required this.chassis,
    required this.date,
    required this.lcAmount,
    required this.bank,
    required this.profit
  });
  Map<String, dynamic> toJson() {
    return {
      'lcNo': lcNo,
      'irc': irc,
      'supplier': supplier,
      'shipment': shipment,
      'chassis': chassis.map((chassis) => chassis.toJson()).toList(),
      'date': date,
      'lcAmount': lcAmount,
      'bank': bank,
      'profit':profit
    };
  }

  LC.fromJson(Map<String, dynamic> json)
      : lcNo = json['lcNo'],
        irc = json['irc'],
        supplier = json['supplier'],
        shipment = json['shipment'],
        chassis = (json['chassis'] as Map<String, dynamic>).values
            .map((chassisJson) => Chassis.fromJson(chassisJson))
            .toList(),
      date = json['date'],
        lcAmount = json['lcAmount'],
        bank = json['bank'],
        profit=json['profit'];
}