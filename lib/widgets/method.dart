import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:smerp/models/chassis_model.dart';


Future<Uint8List> quotationPdf(Chassis item,
    {
      String t = "", ac = "", fit = "", val = "", price = "", method = "",qcode="",currentDate="" //quotation
    }) async {

  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
        build: (context){
         return  pw.Column(
           crossAxisAlignment: pw.CrossAxisAlignment.start,
           mainAxisAlignment: pw.MainAxisAlignment.start,
           children: [
             pw.Center(child: pw.Text("Quotation",style: pw.TextStyle(fontSize:20,fontWeight: pw.FontWeight.bold))),
             pw.SizedBox(height: 30),
             pw.Text("Date: $currentDate"),
             pw.Text('To'),
             pw.Text(t.toString()),
             pw.SizedBox(height: 5),
             pw.Text("A/C: "+ac.toString()),
             pw.SizedBox(height: 3),
             pw.Text("Subject: Quotation of Supply 1(One) Unit Re-Conditioned"),
             pw.SizedBox(height: 10),
             pw.Text("Dear Sir,"
                 "In Response to your query, regarding the vehicle we are pleased to quote the following model with a special price"),
             pw.SizedBox(height: 10),
             pw.Center(child: pw.Text("Description",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold))),
             pw.SizedBox(height: 10),
             pw.Center(
                 child: pw.Table(
                   border: pw.TableBorder.all(),
                   children: [
                     tableRow('1','Brand Name', item.name),
                     tableRow('2','Chassis Number', item.chassis),
                     tableRow('3','Engine Number', item.engineNo),
                     tableRow('4','CC', item.cc),
                     tableRow('3','Color', item.color),
                     tableRow('6','Model', item.model),
                     tableRow('7','Fittings', fit.toString()),
                     tableRow('8','Validity', val),
                     tableRow('9','Price', price),
                     tableRow('10','Payment Method', method),
                   ],
                 )),
             pw.SizedBox(height: 20),
             pw.Text("From the above details, we would request you to please accept our quotation and oblige thereby"),
             pw.SizedBox(height: 50),
             pw.Row(
                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                 children: [
                   pw.Text('Accepted by Customer',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                   pw.Text('Authurized Signature',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                 ]
             ),
           ],
         );
        })
  );

  return pdf.save();
}

Future<Uint8List> challanPdf(Chassis item,
    {
      String t = "", ac = "", tyre ="",ccode="",currentDate=""//challan
    }) async {


  final pdf = pw.Document();
  pdf.addPage(
      pw.Page(
          build: (context){

            return  pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Center(child: pw.Text('Delivery Challan',style: pw.TextStyle(fontSize:20,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 30),
                pw.Text('To'),
                pw.Text(t.toString()),
                pw.SizedBox(height: 10),
                pw.Text("A/C: "+ac.toString()),
                pw.SizedBox(height: 20),
                pw.Center(child: pw.Text("Description",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 20),
                pw.Center(
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        tableRow('1','Brand Name', item.name),
                        tableRow('2','Color', item.color),
                        tableRow('3','Model', item.model),
                        tableRow('4','Chassis Number', item.chassis),
                        tableRow('5','Engine Number', item.engineNo),
                        tableRow('6','CC', item.cc),
                        tableRow('7','Tyre Size', tyre.toString()),
                      ],
                    )),
                pw.SizedBox(height: 15),
                pw.Text("I/We hereby received the above mentioned vehicle in good and running condition"),
                pw.SizedBox(height: 50),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Accepted by Customer',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Authurized Signature',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]
                ),
              ],
            );
          })
  );

  return pdf.save();
}

Future<Uint8List> billPdf(Chassis item,
    {
      String t = "", ac = "", cpaid = "", bpaid = "", total = "" ,price="",bank="",inWord="",bcode="",currentDate=""//customer
    }) async {

  final pdf = pw.Document();
  pdf.addPage(
      pw.Page(
          build: (context){

            pw.Border myBorder = pw.Border(
              left: pw.BorderSide(
                width: 1.0,
              ),
              top: pw.BorderSide.none,
              right: pw.BorderSide(
                width: 1.0,
              ),
              bottom: pw.BorderSide.none,
            );
            return  pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Center(child: pw.Text("Bill",style: pw.TextStyle(fontSize:20,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 30),
                pw.Text("To"),
                pw.Text(t.toString()),
                pw.SizedBox(height: 5),
                pw.Text("A/C: "+ ac.toString()),
                pw.SizedBox(height: 3),
                pw.Text("Subject: Bill of One Unit Reconditioned "+item.name.toString()),
                pw.SizedBox(height: 15),
                pw.Center(
                    child: pw.Row(
                      children: [
                       pw.Column(
                         mainAxisAlignment: pw.MainAxisAlignment.start,
                         children: [
                           pw.Container(
                             width: 500, // Specify the desired width
                             child: pw.Table(
                               border: pw.TableBorder.all(),
                               children: [
                                 pw.TableRow(
                                   children: [
                                    pw.Container(
                                      width:234,
                                      child:  pw.Padding(
                                        padding: const pw.EdgeInsets.all(4),
                                        child: pw.Center(
                                          child: pw.Text(' Description')
                                        ),
                                      )
                                    ),
                                     pw.Padding(
                                       padding: const pw.EdgeInsets.all(4),
                                       child: pw.Text('  Unit Price'),
                                     ),
                                     pw.Padding(
                                       padding: const pw.EdgeInsets.all(4),
                                       child: pw.Text('Total Price'),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                          pw.Container(
                            width: 500,
                            decoration: pw.BoxDecoration(
                              border: myBorder,
                            ),
                            child: pw.Row(
                              children: [
                               pw.Container(
                                 decoration: pw.BoxDecoration(
                                   border: myBorder,
                                 ),
                                 child:  pw.Row(
                                     children: [
                                       pw.Container(
                                         width: 320,
                                         child: pw.Table(
                                             border: pw.TableBorder.all(),
                                             children: [
                                               billRow('Brand Name', item.name),
                                               billRow('Chassis Number', item.chassis,),
                                               billRow('Engine Number',item.engineNo,),
                                               billRow('CC',item.cc,),
                                               billRow('Color',item.color,),
                                               billRow('Model',item.model,),
                                             ]
                                         ),
                                       ),
                                       pw.Container(
                                         width: 91,
                                         child: pw.Padding(
                                             padding: pw.EdgeInsets.symmetric(horizontal: 8),
                                             child: pw.Text(price.toString())
                                         ),
                                       ),
                                     ]
                                 ),
                               ),
                              ]
                            )
                          ),
                          pw.Container(
                            width: 500,
                            child:  pw.Table(
                                border: pw.TableBorder.all(),
                                children: [
                                  billBottomRow('Amount Paid by '+bank.toString(),'       ', bpaid.toString(),),
                                  billBottomRow('Amount Paid by Customer','       ', cpaid.toString(),),
                                  billBottomRow('Total Price             ',price.toString(), price.toString(),),
                                ]
                            ),
                          ),
                           pw.Container(
                             width: 500, // Specify the desired width
                             child: pw.Table(
                               border: pw.TableBorder.all(),
                               children: [
                                 pw.TableRow(
                                   children: [
                                  pw.Container(
                                    width:87,
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(4),
                                      child: pw.Text('In Word BDT'),
                                    ),
                                  ),
                                    pw.Container(
                                      width: 413,
                                      child:  pw.Padding(
                                        padding: const pw.EdgeInsets.all(4),
                                        child: pw.Text(inWord.toString()),
                                      ),
                                    )
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ]
                       )
                      ]
                    )),
                pw.SizedBox(height: 10),
                pw.Text("From the above details, we would request you to please accept our quotation and oblige thereby"),
                pw.SizedBox(height: 50),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Accepted by Customer',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Authurized Signature',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]
                ),
              ],
            );
          })
  );

  return pdf.save();
}

Future<Uint8List> bankPdf(Chassis item,
    {
      String t = "", ac = "", po ="", bpaid = "",price="",bank="",branch="", inWord="",bacode="",currentDate=""//customer
    }) async {
  final pdf = pw.Document();
  pdf.addPage(
      pw.Page(
          build: (context){
            return  pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Center(child: pw.Text("Money Receipt",style: pw.TextStyle(fontSize:20,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 30),
                pw.Text("To"),
                pw.Text(t.toString()),
                pw.SizedBox(height: 5),
                pw.Text("A/C: "+ ac.toString()),
                pw.SizedBox(height: 10),
                pw.Center(child: pw.Text("Description",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 15),
                pw.Center(
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        tableRow('1','Vehicle Name', item.name),
                        tableRow('2','Color', item.color),
                        tableRow('3','Model', item.model),
                        tableRow('4','Chassis Number', item.chassis),
                        tableRow('5','Engine Number', item.engineNo),
                        tableRow('6','CC', item.cc),
                        tableRow('7','Vehicle Price', price.toString()),
                        tableRow('8','Amount Paid by Bank', bpaid.toString()),
                        tableRow('9','Cheque No or P/O No', po.toString()),
                        tableRow('10','Bank', bank.toString()),
                        tableRow('11','Branch', branch.toString()),
                        tableRow('11','In Word BDT',inWord.toString()),
                      ],
                    )),
                pw.SizedBox(height: 50),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Signature of Customer',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Authurized Signature',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]
                ),
              ],
            );
          })
  );

  return pdf.save();
}

Future<Uint8List> customerPdf(Chassis item,
    {
      String name = "", address = "", phone ="", cpaid = "",price="", inWord="",cocode="",currentDate=""//customer
    }) async {
  final pdf = pw.Document();
  pdf.addPage(
      pw.Page(
          build: (context){
            return  pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Center(child: pw.Text("Money Reciept",style: pw.TextStyle(fontSize: 20,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 30),
                pw.Text("Customer Name: "+name.toString()),
                pw.SizedBox(height: 3),
                pw.Text("Address: "+ address.toString()),
                pw.SizedBox(height: 3),
                pw.Text("Phone Number: "+ phone.toString()),
                pw.SizedBox(height: 10),
                pw.Center(child: pw.Text("Description",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 15),
                pw.Center(
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        tableRow('1','Vehicle Name', item.name),
                        tableRow('2','Color', item.color),
                        tableRow('3','Model', item.model),
                        tableRow('4','Chassis Number', item.chassis),
                        tableRow('5','Engine Number', item.engineNo),
                        tableRow('6','CC', item.cc),
                        tableRow('7','Vehicle Price', price.toString()),
                        tableRow('8','Amount Paid by Customer', cpaid.toString()),
                        tableRow('11','In Word BDT',inWord.toString()),
                      ],
                    )),
                pw.SizedBox(height: 50),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Signature of Customer',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Authurized Signature',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]
                ),
              ],
            );
          })
  );

  return pdf.save();
}



pw.TableRow tableRow(String sl,String type,String item) {
  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Center(
                          child: pw.Text('$sl'),
                        )
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 8,top: 4,bottom: 4),
                        child: pw.Text('$type'),
                      ),
                  pw.Container(
                    width: 220,
                    child:     pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 8,top: 4,bottom: 4),
                      child: type=="Price in Word"||type=="In Word BDT"?pw.Container(
                          child: pw.Text('$item tk only')):pw.Text(item),
                    ),
                  )

                    ],
                  );
}

pw.TableRow billBottomRow(String sl,String type,String item) {
  return pw.TableRow(
    children: [
      pw.Container(
        width: 320,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('$sl'),
        ),
      ),
      pw.Container(
        width: 91,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('$type'),
        ),
      ),
      pw.Container(
        width: 89,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: type=="Price in Word"||type=="In Word BDT"?pw.Container(
              child: pw.Text('$item tk only')):pw.Text(item),
        ),
      ),

    ],
  );
}

pw.TableRow billRow(String sl,String type,) {
  return pw.TableRow(
    children: [
      pw.Container(
        width: 130,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('$sl'),
        ),
      ),
      pw.Container(
        width: 290,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Expanded(
            child: pw.Text('$type'),
          ),
        ),
      ),
    ],
  );
}

TableRow TableItem(String sl,String type,String item) {
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
          child: type=="Price in Word"||type=="In Word BDT"?Text('$item tk Only'):Text('$item'),
        ),
      ),
    ],
  );
}




