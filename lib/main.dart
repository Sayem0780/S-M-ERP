import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smerp/lc/lc_continue_screen.dart';
import 'package:smerp/lc/lc_entey.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/models/chassis_model.dart';
import 'package:smerp/models/pdf_models/pdf_bill.dart';
import 'package:smerp/models/pdf_models/pdf_challan.dart';
import 'package:smerp/models/pdf_models/pdf_cutomer.dart';
import 'package:smerp/models/pdf_models/pdf_quotation.dart';
import 'package:smerp/screen/booked.dart';
import 'package:smerp/screen/report/bank_report.dart';
import 'package:smerp/screen/report/bill_report.dart';
import 'package:smerp/screen/quotation_screen.dart';
import 'package:smerp/screen/report/challan_report.dart';
import 'package:smerp/screen/report/quotation_report.dart';
import 'package:smerp/screen/reportSelection.dart';
import 'package:smerp/screen/report/report_customer.dart';
import 'package:smerp/screen/unsold.dart';
import 'package:smerp/screen/vat.dart';
import 'package:window_manager/window_manager.dart';
import 'home_page.dart';
import 'lc/chasis_entry.dart';
import 'models/lc_model.dart';
import 'models/pdf_models/pdf_bank.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      WindowManager.instance.setMinimumSize(Size(1280, 600));
    });
  }
  var path = Directory('sm_erp');
  Hive.init(path.absolute.path);
  Hive.registerAdapter(ChassisAdapter());
  Hive.registerAdapter(LCAdapter());
  Hive.registerAdapter(CustomAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(BankAdapter());
  Hive.registerAdapter(ChallanAdapter());
  Hive.registerAdapter(QuotationAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purpleAccent,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName:(context)=> HomePage(),
        ChasisEntry.routeName:(context)=>ChasisEntry(),
        LcContinueScreen.routeName:(context)=>LcContinueScreen(),
        LcEntry.routeName:(context)=>LcEntry(),
        LcReportScreen.routeName:(context)=> LcReportScreen(),
        UnsoldScreen.routeName:(context)=>UnsoldScreen(),
        BookedScreen.routeName:(context)=>BookedScreen(),
        NotGivenVatScreen.routeName:(context)=>NotGivenVatScreen(),
        QuotationScreen.routeName:(context)=>QuotationScreen(),
        CustomerReport.routeName:(context)=>CustomerReport(),
        BillReport.routeName:(context)=>BillReport(),
        BankReport.routeName:(context)=>BankReport(),
        ChallanReport.routeName:(context)=>ChallanReport(),
        ReportSelectionPage.routeName:(context)=>ReportSelectionPage(),
        QuotationReport.routeName:(context)=>QuotationReport(),

      },
    );
  }
}
