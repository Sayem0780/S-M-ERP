import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part'lc_model.g.dart';
@HiveType(typeId: 0)
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
  dynamic bank;
  LC({
  required this.lcNo,
  required this.irc,
  required this.supplier,
  required this.shipment,
  required this.chassis,
    required this.date,
    required this.lcAmount,
    required this.bank,
  });
}