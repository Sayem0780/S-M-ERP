import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smerp/lc/lc_entey.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/providers/auth.dart';
import 'package:smerp/screen/verticals/booked.dart';
import 'package:smerp/screen/verticals/bank_sale_screen.dart';
import 'package:smerp/screen/verticals/customer_sale_screen.dart';
import 'package:smerp/screen/reportSelection.dart';
import 'package:smerp/screen/verticals/unsold.dart';
import 'package:smerp/screen/verticals/vat.dart';

import '../providers/contents.dart';
import 'defautls/login.dart';


class HomePage extends StatefulWidget {
  static const routeName='/home page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Contents>(context).fetchAndPrintPosts();
   Auth a = Provider.of<Auth>(context);
    return a.isAuth?Scaffold(
      appBar: AppBar(title: Text('SM Automobile'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
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
                },color: Theme.of(context).primaryColorDark,child: Text("Bank Sale",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,)),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 200,
              child: MaterialButton(onPressed: ()async{
                Navigator.of(context).pushNamed(CustomerSealScreen.routeName);
              },color: Theme.of(context).primaryColorDark,child: Text("Customer Sale",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),textColor: Colors.white,),
            ),
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
            TextButton(onPressed: (){
              a.logOut();
            }, child: Text("Log Out",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),)),
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
    ):LogInPage();
  }
}
