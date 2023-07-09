import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smerp/lc/lc_continue_screen.dart';
import 'package:smerp/lc/lc_entey.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/screen/report/bank_report.dart';
import 'package:smerp/screen/report/bill_report.dart';
import 'package:smerp/screen/quotation_screen.dart';
import 'package:smerp/screen/report/challan_report.dart';
import 'package:smerp/screen/report/quotation_report.dart';
import 'package:smerp/screen/report/report_customer.dart';
import 'package:smerp/screen/unsold.dart';
import 'package:smerp/screen/vat.dart';


class ReportSelectionPage extends StatefulWidget {
  static const routeName='/report page';
  const ReportSelectionPage({Key? key}) : super(key: key);

  @override
  State<ReportSelectionPage> createState() => _ReportSelectionPageState();


}

class _ReportSelectionPageState extends State<ReportSelectionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SM Automobile'),centerTitle: true,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 200,
              child: MaterialButton(onPressed: ()async{
                Navigator.of(context).pushNamed(BillReport.routeName);
              },color: Theme.of(context).primaryColorDark,child: Text("Bill",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,),
            ),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(ChallanReport.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Challan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(QuotationReport.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(CustomerReport.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Customer Reciept",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),

            SizedBox(height: 20,),

            Container(
              height: 50,
              width: 200,
              child: MaterialButton(onPressed: ()async{
                Navigator.of(context).pushNamed(BankReport.routeName);
              },color: Theme.of(context).primaryColorDark,child: Text("Bank Reciept",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
