import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:smerp/lc/lc_entey.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/models/chassis_model.dart';
import 'package:smerp/models/pdf_models/pdf_bill.dart';
import 'package:smerp/models/pdf_models/pdf_challan.dart';
import 'package:smerp/models/pdf_models/pdf_cutomer.dart';
import 'package:smerp/models/pdf_models/pdf_quotation.dart';
import 'package:smerp/providers/auth.dart';
import 'package:smerp/providers/contents.dart';
import 'package:smerp/screen/defautls/login.dart';
import 'package:smerp/screen/defautls/signup.dart';
import 'package:smerp/screen/report/sale_customer_report.dart';
import 'package:smerp/screen/verticals/booked.dart';
import 'package:smerp/screen/verticals/customer_sale_screen.dart';
import 'package:smerp/screen/report/bank_report.dart';
import 'package:smerp/screen/report/bill_report.dart';
import 'package:smerp/screen/verticals/bank_sale_screen.dart';
import 'package:smerp/screen/report/challan_report.dart';
import 'package:smerp/screen/report/quotation_report.dart';
import 'package:smerp/screen/reportSelection.dart';
import 'package:smerp/screen/report/report_customer.dart';
import 'package:smerp/screen/verticals/unsold.dart';
import 'package:smerp/screen/verticals/vat.dart';
import 'package:window_manager/window_manager.dart';
import 'screen/home_page.dart';
import 'lc/chasis_entry.dart';
import 'models/lc_model.dart';
import 'models/pdf_models/pdf_bank.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/pdf_models/pdf_sale_customer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WindowManager.instance.setMinimumSize(const Size(1280, 600));
    });
  }

  // Get the app's local app data directory for Windows
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  // // Hive.init(appDirectory.path);
  // var path = Directory(appDirectory.path);
  // print(appDirectory.path);
  Hive.init(appDirectory.path);
  Hive.registerAdapter(ChassisAdapter());
  Hive.registerAdapter(LCAdapter());
  Hive.registerAdapter(CustomAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(BankAdapter());
  Hive.registerAdapter(ChallanAdapter());
  Hive.registerAdapter(QuotationAdapter());
  Hive.registerAdapter( SaleCustomAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Contents(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
          child: MyApp(),
        ),
      ],
    child: Consumer<Auth>(

      builder: (ctx, auth, child) =>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.purpleAccent,
        ),
        // initialRoute: auth.isAuth?SignUp.routeName:HomePage.routeName,
        // home: auth.isAuth?HomePage():LogInPage(),
        home: HomePage(),
        routes: {
          SignUp.routeName:(context)=> const SignUp(),
          LogInPage.routeName:(context)=> const LogInPage(),
          HomePage.routeName:(context)=> const HomePage(),
          ChasisEntry.routeName:(context)=>const ChasisEntry(),
          // LcContinueScreen.routeName:(context)=>const LcContinueScreen(),
          LcEntry.routeName:(context)=>const LcEntry(),
          LcReportScreen.routeName:(context)=> const LcReportScreen(),
          UnsoldScreen.routeName:(context)=>const UnsoldScreen(),
          BookedScreen.routeName:(context)=>const BookedScreen(),
          NotGivenVatScreen.routeName:(context)=>const NotGivenVatScreen(),
          QuotationScreen.routeName:(context)=>const QuotationScreen(),
          CustomerReport.routeName:(context)=>const CustomerReport(),
          BillReport.routeName:(context)=>const BillReport(),
          BankReport.routeName:(context)=>const BankReport(),
          ChallanReport.routeName:(context)=>const ChallanReport(),
          ReportSelectionPage.routeName:(context)=>const ReportSelectionPage(),
          QuotationReport.routeName:(context)=>const QuotationReport(),
          CustomerSealScreen.routeName:(context)=>const CustomerSealScreen(),
          CustomerReport.routeName:(context)=> const CustomerReport(),
          SaleCustomerReport.routeName:(context)=> const SaleCustomerReport(),
        },
      ),
    ),);
  }
}
