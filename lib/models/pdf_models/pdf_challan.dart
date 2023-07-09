import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_challan.g.dart';
@HiveType(typeId: 0)
class Challan extends HiveObject{
  @HiveField(0)
  final Chassis a;
  @HiveField(1)
  final String intro;
  @HiveField(2)
  final String ac;
  @HiveField(3)
  final String tyre;
  @HiveField(4)
  final String ccode;
  @HiveField(5)
  final String currentDate;
  Challan({
    required this.a,
    required this.intro,
    required this.ac,
    required this.tyre,
    required this.ccode,
    required this.currentDate
});
}