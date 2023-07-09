import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smerp/home_page.dart';
import 'package:smerp/lc/chasis_entry.dart';
import 'package:smerp/models/chassis_model.dart';

import '../models/lc_model.dart';

class LcContinueScreen extends StatefulWidget {
  static const routeName = '/lc continue';

  const LcContinueScreen({Key? key}) : super(key: key);

  @override
  State<LcContinueScreen> createState() => _LcContinueScreenState();
}

class _LcContinueScreenState extends State<LcContinueScreen> with WidgetsBindingObserver {
  LC? a;
  late Box<LC?> _box;
  Chassis? selectedChassis;
  bool isSecondSegmentVisible = false;
  bool isEditable = false;
  List<Chassis> chassisList = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this as WidgetsBindingObserver);
    openBox();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this as WidgetsBindingObserver);
    _box.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Close the box when the app is paused or the user leaves the page
      _box.close();
    } else if (state == AppLifecycleState.resumed) {
      // Open the box when the app is resumed or the user enters the page
      openBox();
    }
  }


  Future<void> openBox() async {
    _box = await Hive.openBox<LC?>('mbox');

    a = _box.values.last;
    chassisList = a!.chassis.toList();
  }

  void showSecondSegment(int index) {
    setState(() {
      selectedChassis = a!.chassis.elementAt(index);
      isSecondSegmentVisible = true;
    });
  }

  void hideSecondSegment() {
    setState(() {
      selectedChassis = null;
      isSecondSegmentVisible = false;
    });
  }

  void searchUnSold() {
    List<Chassis>b=[];
    List<LC> matchingLCs = _box.values.toList() as List<LC>;
    for(int i =0; i<matchingLCs.length;i++){
      List<Chassis> a = matchingLCs[i].chassis.toList();
      for(int j=0;j<a.length;j++){
        if(a[j].sold=='Unsold'){
          b.add(a[i]);
        }
      }
    }

    setState(() {
      if (b.isNotEmpty) {
        chassisList = b;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        dispose();
        Navigator.of(context).pushNamed(HomePage.routeName,);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chassis Entry'),
        ),
        body: FutureBuilder<void>(
          future: openBox(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                double w = MediaQuery.of(context).size.width;
                return Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: isSecondSegmentVisible?1*(w/1336):3.0*((w/1336)),
                        ),

                        itemCount: chassisList.length,
                        itemBuilder: (context, index) {
                          // final chassis = _chassisBox.getAt(index);
                          final chassis = chassisList[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showSecondSegment(index);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        chassis!.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      AutoSizeText(
                                        'Total: ${chassis.total.toString()}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // SizedBox(width: 16),
                    if (isSecondSegmentVisible)
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 16,),
                          color: Colors.grey[200],
                          child: SingleChildScrollView(
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: hideSecondSegment,
                                        ),
                                        Text(
                                          'Name: ${selectedChassis!.name}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [

                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: (){
                                                setState(() {
                                                  isEditable = true;

                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.save),
                                              onPressed: (){
                                                setState(() {
                                                  isEditable = false;
                                                  openBox();
                                                });
                                              },
                                            ),

                                          ],
                                        )
                                      ],
                                    ),

                                    DataTable(
                                      columnSpacing: isEditable ?39:65,
                                      columns: [
                                        DataColumn(label: Text('Field')),
                                        DataColumn(label: Text('Value')),
                                        DataColumn(label: Text('Field')),
                                        DataColumn(label: Text('Value')),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text('Chassis')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.chassis,
                                                onChanged: (newValue) {
                                                  selectedChassis!.chassis = newValue;
                                                  _box.put(a!.key, a);
                                                },
                                              )
                                                  :Text(selectedChassis!.chassis)),
                                          DataCell(Text('Engine No')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.engineNo,
                                                onChanged: (newValue) {
                                                  selectedChassis!.engineNo = newValue;
                                                  _box.put(a!.key, a);
                                                },
                                              )
                                                  :Text(selectedChassis!.engineNo)),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('CC')),
                                          DataCell(
                                            isEditable
                                                ? TextFormField(
                                              initialValue: selectedChassis!.cc,
                                              onChanged: (newValue) {
                                                selectedChassis!.cc = newValue;
                                                _box.put(a!.key, a);
                                              },
                                            )
                                                : Text(selectedChassis!.cc),
                                          ),
                                          DataCell(Text('Color')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.color,
                                                onChanged: (newValue) {
                                                  selectedChassis!.color = newValue;
                                                  _box.put(a!.key, a);
                                                },
                                              )
                                                  :Text(selectedChassis!.color)),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('AP/KM')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.km,
                                                onChanged: (newValue) {
                                                  selectedChassis!.km = newValue;
                                                  _box.put(a!.key, a);
                                                },
                                              )
                                                  :Text(selectedChassis!.km)),
                                          DataCell(Text('Model')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.model,
                                                onChanged: (newValue) {
                                                  selectedChassis!.model = newValue;
                                                  _box.put(a!.key, a);
                                                },
                                              )
                                                  :Text(selectedChassis!.model)),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Sold/Unsold')),
                                          DataCell(
                                              isEditable
                                                  ? DropdownButtonFormField<String>(
                                                value: selectedChassis!.sold,
                                                onChanged: (String? newValue) { // Update the function signature
                                                  if (newValue != null) {
                                                    setState(() {
                                                      selectedChassis!.sold = newValue; // Perform actions based on the selected value
                                                      _box.put(a!.key, a);
                                                    });
                                                  }
                                                },
                                                items: <String>['Sold', 'Unsold'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                                  :Text(selectedChassis!.sold)),
                                          DataCell(Text('VAT')),
                                          DataCell(
                                              isEditable
                                                  ? DropdownButtonFormField<String>(
                                                value: selectedChassis!.vat,
                                                onChanged: (String? newValue) { // Update the function signature
                                                  if (newValue != null) {
                                                    setState(() {
                                                      selectedChassis!.vat = newValue; // Perform actions based on the selected value
                                                      _box.put(a!.key, a);
                                                    });
                                                  }
                                                },
                                                items: <String>['Given', 'Not Given'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                                  :Text(selectedChassis!.vat)),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Delivery date')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.delivery_date.toString(),
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(onPressed: ()async{
                                                      final DateTime? picked = await showDatePicker(
                                                        context: context,
                                                        initialDate: selectedDate,
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2100),
                                                      );

                                                      if (picked != null && picked != selectedDate) {
                                                        setState(() {
                                                          selectedDate = picked;
                                                          var d = DateFormat('yyyy-MM-dd').format(selectedDate);
                                                          selectedChassis!.delivery_date = d.toString();
                                                          _box.put(a!.key, a);
                                                        });
                                                      }
                                                    }, icon: Icon(Icons.date_range))
                                                ),
                                              ):Text(selectedChassis!.delivery_date.toString())),
                                          DataCell(Text('Buying Price')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.buyingPrice.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.buyingPrice = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                },
                                              ):Text(selectedChassis!.buyingPrice.toString())),
                                        ]),
                                        DataRow(cells: [

                                          DataCell(Text('Invoice')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.invoice.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.invoice = double.parse(newValue);
                                                  selectedChassis!.ttAmount = selectedChassis!.buyingPrice - selectedChassis!.invoice;
                                                  _box.put(a!.key, a);
                                                  },

                                              ):Text(selectedChassis!.invoice.toString())),
                                          DataCell(Text('TT')),
                                          DataCell(Text(selectedChassis!.ttAmount.toString())),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Invoice Rate')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.invoiceRate.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.invoiceRate = double.parse(newValue);
                                                  selectedChassis!.invoiceBdt = selectedChassis!.invoiceRate * selectedChassis!.invoice;
                                                  _box.put(a!.key, a);
                                                  },

                                              ):Text(selectedChassis!.invoiceRate.toString())),
                                          DataCell(Text('TT Rate')),
                                          DataCell( isEditable
                                              ? TextFormField(
                                            initialValue: selectedChassis!.ttRate.toString(),
                                            onChanged: (newValue) {
                                              selectedChassis!.ttRate = double.parse(newValue);
                                              selectedChassis!.ttBdt = selectedChassis!.ttAmount* selectedChassis!.ttRate;
                                              _box.put(a!.key, a);
                                              },
                                          ):Text(selectedChassis!.ttRate.toString())),

                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Invoice BDT')),
                                          DataCell(Text(selectedChassis!.invoiceBdt.toString())),
                                          DataCell(Text('TT BDT')),
                                          DataCell(Text(selectedChassis!.ttBdt.toString())),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Cost without Duty')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.portCost.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.portCost = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                  },
                                              ):Text(selectedChassis!.portCost.toString())),
                                          DataCell(Text('Duty')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.duty.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.duty = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                },
                                              ):Text(selectedChassis!.duty.toString())),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('CNF')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.cnf.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.cnf = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                },
                                              ):Text(selectedChassis!.cnf.toString())),
                                          DataCell(Text('Warfrent')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.warfrent.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.warfrent = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                },
                                              ):Text(selectedChassis!.warfrent.toString())),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Others')),
                                          DataCell(
                                              isEditable
                                                  ? TextFormField(
                                                initialValue: selectedChassis!.others.toString(),
                                                onChanged: (newValue) {
                                                  selectedChassis!.others = double.parse(newValue);
                                                  selectedChassis!.total = selectedChassis!.buyingPrice + selectedChassis!.portCost + selectedChassis!.duty + selectedChassis!.cnf+selectedChassis!.warfrent+selectedChassis!.others;
                                                  _box.put(a!.key, a);
                                                },
                                              ):Text(selectedChassis!.others.toString())),
                                          DataCell(Text('Total')),
                                          DataCell(Text(selectedChassis!.total.toString())),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Selling Price')),
                                          DataCell(Text(selectedChassis!.sellingPrice.toString())),
                                          DataCell(Text('Profit')),
                                          DataCell(Text(selectedChassis!.profit.toString())),
                                        ]),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
                                      child: isEditable?TextFormField(
                                        initialValue: selectedChassis!.remark,
                                        maxLines: 4,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: "Enter Others cost details",
                                          labelText: "Remarks",
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (String value) {
                                          selectedChassis!.remark = value;
                                          _box.put(a!.key, a);
                                        },
                                      ):Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(selectedChassis!.remark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){Navigator.of(context).pushNamed(ChasisEntry.routeName,); dispose();},
          child: const Icon(Icons.add,color: Colors.black,),
          backgroundColor: Colors.amber,
        ),
      ),
    );

  }
}
