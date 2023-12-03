import 'package:hive/hive.dart';

import '../chassis_model.dart';
part 'pdf_bank.g.dart';
@HiveType(typeId: 0)
class Bank extends HiveObject{
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
  final String branch;
  @HiveField(6)
  final String bankPay;
  @HiveField(7)
  final String po;
  @HiveField(8)
  final String inWord;
  @HiveField(9)
  final String bacode;
  @HiveField(10)
  final dynamic currentDate;
  Bank({
    required this.a,
    required this.intro,
    required this.ac,
    required this.price,
    required this.bank,
    required this.branch,
    required this.bankPay,
    required this.po,
    required this.inWord,
    required this.bacode,
    required this.currentDate
  });
  Map<String, dynamic> toJson() {
    return {
      'a': a.toJson(), // Assuming a.toJson() returns a Map<String, dynamic>
      'intro': intro,
      'ac': ac,
      'price': price.toString(),
      'bank': bank,
      'branch': branch,
      'bankPay': bankPay,
      'po': po,
      'inWord': inWord,
      'bacode': bacode,
      'currentDate': currentDate
    };
  }

  Bank.fromJson(Map<String, dynamic> json,)
      : a = Chassis.fromJson(json['a']),
        intro = json['intro'],
        ac = json['ac'],
        price= json['price'],
        bank= json['bank'],
        branch= json['branch'],
        bankPay=json['bankPay'],
        po=json['po'],
        inWord=json['inWord'],
        bacode=json['bacode'],
        currentDate=json['currentDate'];
}