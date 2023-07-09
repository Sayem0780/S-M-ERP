import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:smerp/models/chassis_model.dart';
import 'package:smerp/models/pdf_models/pdf_quotation.dart';

import '../method.dart';
class QuotationFormate extends StatefulWidget {
  final Chassis a;
  bool pressed = false;
  static const routeName ='/qutation formate';
  QuotationFormate({Key? key,required this.a}) : super(key: key);
  @override
  State<QuotationFormate> createState() => _QuotationFormateState();
}

class _QuotationFormateState extends State<QuotationFormate> {
  TextEditingController introController = TextEditingController();
  TextEditingController acController = TextEditingController();
  TextEditingController fittingsController = TextEditingController();
  TextEditingController validityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  String intro="",fittings="",validity="",price="",payment_method="",ac ="";
  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final qcode = UniqueKey().toString();
  void saveData() async {
    final box = await Hive.openBox('quotatioBox'); // Open the Hive box

    // Create an instance of the Custom class and populate its fields with the data
    final customData = Quotation(
        a: widget.a,
        intro: intro,
        ac: ac,
        fittings: fittings,
        validity: validity,
        price: price.toString(),
        payment_method: payment_method,
        qcode: qcode,
        currentDate: currentDate);

    await box.add(customData); // Add the customData object to the box

    await box.close(); // Close the box when done

    print('Data saved successfully!');
  }
  @override
  Widget build(BuildContext context) {

    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      body: widget.pressed?PdfPreview(
        build: (format) => quotationPdf(widget.a,t: intro,ac: ac,fit: fittings,val: validity,price: price,method: payment_method,qcode: qcode,currentDate: currentDate),
      ):Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Quotation")),
                SizedBox(height: 20,),
                Text("Date: $currentDate"),
                Text('To'),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0,),
                  child: TextFormField(
                    controller: introController,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        intro = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0,),
                  child: TextFormField(
                    controller: acController,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'A/C: '
                    ),
                    onChanged: (String value) {
                      setState(() {
                        ac = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Text("Subject: Quotation of Supply 1(One) Unit Re-Conditioned"),
                Container(
                  child: Text("Dear Sir,"
                      "In Response to your query, regarding the vehicle we are pleased to quote the following model with a special price"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(.25),   // Width for the first column
                      1: FlexColumnWidth(2),   // Width for the second column
                      2: FlexColumnWidth(3),   // Width for the third column
                    },
                    border: TableBorder.all(), // optional: add border to the table
                    children: [
                      TableItem('1','Brand name', widget.a.name),
                      TableItem('2','Chassis No', widget.a.chassis),
                      TableItem('3','Engine No', widget.a.engineNo),
                      TableItem('4','CC', widget.a.cc),
                      TableItem('3','Color', widget.a.color),
                      TableItem('6','Model', widget.a.model),
                      InputItem('7','Fittings',fittings,fittingsController,line: 3),
                      InputItem('8','Validity', validity,validityController),
                      InputItem('9','Price', price,priceController),
                      InputItem('10','Payment Method',payment_method,paymentController),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(child: Text("From the above details, we would request you to please accept our quotation and oblige thereby"),),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Accepted by Customer"),
                    MaterialButton(onPressed: (){
                      setState(() {
                        widget.pressed = true;
                        saveData();
                      });
                    },textColor: Colors.white, color: Colors.purpleAccent,child: Text("Save"),),
                    Text("Authurized Signature")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  TableRow InputItem(String sl,String type,String item,TextEditingController cnt,{int line = 1}) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$sl'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$type'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: cnt,
              maxLines: line,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  if (type == 'Fittings') {
                    fittings = value;
                  } else if (type == 'Validity') {
                    validity = value;
                  } else if (type == 'Price') {
                    price = value;
                  } else if (type == 'Payment Method') {
                    payment_method = value;
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

}
