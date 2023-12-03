import 'package:hive/hive.dart';

import '../chassis_model.dart';
part 'pdf_bill.g.dart';
@HiveType(typeId: 1)
class Bill extends HiveObject {
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

  Map<String, dynamic> toJson() {
    return {
      'a': a.toJson(), // Assuming a.toJson() returns a Map<String, dynamic>
      'intro': intro,
      'ac': ac,
      'price': price.toString(),
      'bank': bank,
      'bankPay': bankPay,
      'customer': customer,
      'total': total,
      'inWord':inWord,
      'bcode': bcode,
      'currentDate': currentDate
    };
  }

  Bill.fromJson(Map<String, dynamic> json,)
      : a = Chassis.fromJson(json['a']),
        intro = json['intro'],
        ac = json['ac'],
        price= json['price'],
        bank= json['bank'],
        bankPay=json['bankPay'],
        customer=json['customer'],
        total=json['total'],
        inWord=json['inWord'],
        bcode=json['bcode'],
        currentDate=json['currentDate'];
}