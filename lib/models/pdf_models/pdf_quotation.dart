import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_quotation.g.dart';
@HiveType(typeId: 0)
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
}