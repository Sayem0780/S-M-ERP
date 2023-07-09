import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smerp/lc/lc_continue_screen.dart';
import 'package:smerp/lc/lc_entey.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/screen/booked.dart';
import 'package:smerp/screen/quotation_screen.dart';
import 'package:smerp/screen/reportSelection.dart';
import 'package:smerp/screen/report/report_customer.dart';
import 'package:smerp/screen/unsold.dart';
import 'package:smerp/screen/vat.dart';

import 'models/lc_model.dart';

class HomePage extends StatefulWidget {
  static const routeName='/home page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   openBox();
  // }
  //
  // Future<void> openBox() async {
  //   print('Hello');
  //  var box = await Hive.openBox('sbox');
  //  var lcList = box.values.toList();
  //   print(box.keys);
  //   for(int i = 3; i<lcList.length;i++){
  //     LC lc = lcList[i] as LC;
  //     lc.bank ="IFIC";
  //     box.put(lc.key, lc);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SM Automobile'),centerTitle: true,automaticallyImplyLeading: false,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 200,
              child: MaterialButton(onPressed: ()async{
                 Navigator.of(context).pushNamed(LcReportScreen.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("LC Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,),
            ),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(QuotationScreen.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(UnsoldScreen.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Unsold List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),
            SizedBox(height: 20,),
            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(NotGivenVatScreen.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("VAT List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),

            SizedBox(height: 20,),

            Container(
                height: 50,
                width: 200,
                child: MaterialButton(onPressed: (){
                  Navigator.of(context).pushNamed(BookedScreen.routeName);
                },color: Theme.of(context).primaryColorDark,child: Text("Booked List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),

            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 200,
              child: MaterialButton(onPressed: ()async{
                Navigator.of(context).pushNamed(ReportSelectionPage.routeName);
              },color: Theme.of(context).primaryColorDark,child: Text("Report",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.of(context).pushNamed(LcEntry.routeName);},
        child: const Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
