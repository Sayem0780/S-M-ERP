import 'package:hive/hive.dart';

import '../chassis_model.dart';
part 'pdf_bill.g.dart';
@HiveType(typeId: 0)
class Bill extends HiveObject{
  @HiveField(0)
  final Chassis a;
  @HiveField(1)
  final String intro;
  @HiveField(2)
  final String ac;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String bank;
  @HiveField(5)
  final String bankPay;
  @HiveField(6)
  final String customer;
  @HiveField(7)
  final String total;
  @HiveField(8)
  final String inWord;
  @HiveField(9)
  final String bcode;
  @HiveField(10)
  final dynamic currentDate;
  Bill({
    required this.a,
    required this.intro,
    required this.ac,
    required this.price,
    required this.bank,
    required this.bankPay,
    required this.customer,
    required this.total,
    required this.inWord,
    required this.bcode,
    required this.currentDate
  });

}