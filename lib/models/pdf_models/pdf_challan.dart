import 'package:hive/hive.dart';
import 'package:smerp/models/chassis_model.dart';
part 'pdf_challan.g.dart';
@HiveType(typeId: 2)
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

  Map<String, dynamic> toJson() {
    return {
      'a': a.toJson(), // Assuming a.toJson() returns a Map<String, dynamic>
      'intro': intro,
      'ac': ac,
      'tyre': tyre,
      'ccode': ccode,
      'currentDate': currentDate
    };
  }

  Challan.fromJson(Map<String, dynamic> json,)
      : a = Chassis.fromJson(json['a']),
        intro = json['intro'],
        ac = json['ac'],
        tyre= json['tyre'],
        ccode=json['ccode'],
        currentDate=json['currentDate'];

}