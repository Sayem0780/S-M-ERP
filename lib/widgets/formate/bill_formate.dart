import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:smerp/models/chassis_model.dart';
import 'package:smerp/models/pdf_models/pdf_bill.dart';
import 'package:smerp/widgets/method.dart';

import '../methods/numberToWord.dart';
class BillFormate extends StatefulWidget {
  final Chassis a;
  bool pressed = false;
  static const routeName ='/bill formate';
  BillFormate({Key? key,required this.a}) : super(key: key);
  @override
  State<BillFormate> createState() => _BillFormateState();
}

class _BillFormateState extends State<BillFormate> {
  TextEditingController introController = TextEditingController();
  TextEditingController acController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController bank_payController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  String intro="",address="",bank="",branch="",inWord="",ac="";
  double bankPay= 0,customer=0,total=0,price = 0;
  final bcode = UniqueKey().toString();
  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  void updateTotal() {
    setState(() {
      total = bankPay+customer;
      totalController.text = total.toString();
    });
  }
  void word(){
    setState(() {
      double a = double.parse(priceController.text.toString());
      inWord = convertNumberToWord(a) ;
      print(inWord);
    });
  }

  void saveData() async {
    final box = await Hive.openBox('billBox'); // Open the Hive box

    // Create an instance of the Custom class and populate its fields with the data
    final customData = Bill(a: widget.a, intro: intro, ac: ac, price: price.toString(), bank: bank, bankPay: bankPay.toString(), customer: customer.toString(), total: total.toString(), inWord: inWord, bcode: bcode, currentDate: currentDate);

    await box.add(customData); // Add the customData object to the box

    await box.close(); // Close the box when done

    print('Data saved successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pressed?PdfPreview(
        build: (format) => billPdf(widget.a,t: intro,ac:ac,price: price, bank: bank,bpaid: bankPay,cpaid: customer,total: total,inWord: inWord,bcode: bcode,currentDate: currentDate),
      ):Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Bill")),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5),
                  child: TextFormField(
                    controller: introController,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        intro = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5),
                  child: TextFormField(
                    controller: acController,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'A/C: ',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        ac = value;
                      });
                    },
                  ),
                ),
                Text("Subject: Bill of One Unit Reconditioned "+ widget.a.name),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(.28),   // Width for the first column
                      1: FlexColumnWidth(2),   // Width for the second column
                      2: FlexColumnWidth(3),   // Width for the third column
                    },
                    border: TableBorder.all(), // optional: add border to the table
                    children: [
                      TableItem('1','Vehicle', widget.a.name),
                      TableItem('2','Color', widget.a.color),
                      TableItem('3','Model', widget.a.model),
                      TableItem('4','Chassis No', widget.a.chassis),
                      TableItem('5','Engine No', widget.a.engineNo),
                      TableItem('6','CC', widget.a.cc),
                      InputItem('7', 'Bank Name',bank, bankController),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('8'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Unit Price'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: priceController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                 setState(() {
                                   price = double.parse(value);
                                 });
                                  word();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('9'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Amount Paid by Bank'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: bank_payController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                 setState(() {
                                   bankPay = double.parse(value);
                                 });
                                  updateTotal();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('10'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Amount Paid by Customer'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: customerController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                  onChanged: (String value) {
                                   setState(() {
                                     customer = double.parse(value);
                                   });
                                    updateTotal();
                                  },
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('11'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Total'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Total Paid: "+totalController.text),
                                  Text("Total Price: "+priceController.text),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableItem('12', 'In Word BDT', inWord)
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Signature of Customer"),
                    MaterialButton(onPressed: (){
                      setState(() {
                        widget.pressed = true;
                        saveData();
                      });
                    },textColor: Colors.white, color: Colors.purpleAccent,child: Text("Save"),),
                    Text("Authurized Signature")
                  ],
                )
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
                  if (type == 'Bank Name') {
                    setState(() {
                      bank = value;
                    });
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
