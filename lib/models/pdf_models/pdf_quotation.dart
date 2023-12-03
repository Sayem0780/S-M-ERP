import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_quotation.g.dart';
@HiveType(typeId: 5)
class Quotation extends HiveObject{
  @HiveField(0)
  final Chassis a;
  @HiveField(1)
  final String intro;
  @HiveField(2)
  final String ac;
  @HiveField(3)
  final String fittings;
  @HiveField(4)
  final String validity;
  @HiveField(5)
  final String price;
  @HiveField(6)
  final String payment_method;
  @HiveField(7)
  final String qcode;
  @HiveField(8)
  final String currentDate;
  Quotation({
    required this.a,
    required this.intro,
    required this.ac,
    required this.fittings,
    required this.validity,
    required this.price,
    required this.payment_method,
    required this.qcode,
    required this.currentDate
  });

  Map<String, dynamic> toJson() {
    return {
      'a': a.toJson(), // Assuming a.toJson() returns a Map<String, dynamic>
      'intro': intro,
      'ac': ac,
      'fittings': fittings,
      'validity': validity,
      'price': price.toString(),
      'payment_method': payment_method,
      'qcode': qcode,
      'currentDate': currentDate
    };
  }

  Quotation.fromJson(Map<String, dynamic> json)
      : a = Chassis.fromJson(json['a']),
        intro = json['intro'],
        ac = json['ac'],
        fittings = json['fittings'],
        validity = json['validity'],
        price = json['price'],
        payment_method = json['payment_method'],
        qcode = json['qcode'],
        currentDate = json['currentDate'];


}