import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_sale_customer.g.dart';
@HiveType(typeId: 0)
class SaleCustom extends HiveObject{
  @HiveField(0)
  final Chassis a;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String intro;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final String customerPay;
  @HiveField(7)
  final String inWord;
  @HiveField(8)
  final String balance;
  @HiveField(9)
  final dynamic currentDate;
  @HiveField(10)
  final String cheque;
  @HiveField(11)
  final String bank;
  @HiveField(12)
  final String branch;
  @HiveField(13)
  final String tyre;
  SaleCustom({
    required this.a,
    required this.name,
    required this.intro,
    required this.price,
    required this.address,
    required this.phone,
    required this.customerPay,
    required this.inWord,
    required this.balance,
    required this.currentDate,
    required this.cheque,
    required this.bank,
    required this.branch,
    required this.tyre
  });

}
