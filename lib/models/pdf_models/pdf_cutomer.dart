import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_cutomer.g.dart';
@HiveType(typeId: 3)
class Custom extends HiveObject{
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
  final String cocode;
  @HiveField(9)
  final dynamic currentDate;
  Custom({
    required this.a,
    required this.name,
    required this.intro,
    required this.price,
    required this.address,
    required this.phone,
    required this.customerPay,
    required this.inWord,
    required this.cocode,
    required this.currentDate
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
      'cocode': cocode,
      'currentDate': currentDate
    };
  }

  Custom.fromJson(Map<String, dynamic> json,)
      : a = Chassis.fromJson(json['a']),
        name = json['name'],
        intro = json['intro'],
        price= json['price'],
        address= json['address'],
        phone=json['phone'],
        customerPay=json['customerPay'],
        inWord=json['inWord'],
        cocode=json['cocode'],
        currentDate=json['currentDate'];
}
