import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_sale_customer.g.dart';
@HiveType(typeId: 6)
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

  Map<String, dynamic> toJson() {
    return {
      'a': a.toJson(), // Assuming a.toJson() returns a Map<String, dynamic>
      'name': name,
      'intro': intro,
      'price': price.toString(),
      'address': address,
      'phone': phone,
      'customerPay': customerPay,
      'inWord': inWord,
      'balance': balance,
      'currentDate': currentDate,
      'cheque':cheque,
      'bank':bank,
      'branch':branch,
      'tyre':tyre,
    };
  }

  SaleCustom.fromJson(Map<String, dynamic> json,)
      : a = Chassis.fromJson(json['a']),
        name = json['name'],
        intro = json['intro'],
        price= json['price'],
        address= json['address'],
        phone=json['phone'],
        customerPay=json['customerPay'],
        inWord=json['inWord'],
        balance=json['balance'],
        currentDate=json['currentDate'],
        cheque=json['cheque'],
        bank=json['bank'],
        branch=json['branch'],
        tyre=json['tyre'];
}
