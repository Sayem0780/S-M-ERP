import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smerp/screen/home_page.dart';
import 'package:smerp/models/chassis_model.dart';

import '../../models/lc_model.dart';
import '../../providers/contents.dart';

class NotGivenVatScreen extends StatefulWidget {
  static const routeName = '/notgivenvat';

  const NotGivenVatScreen({Key? key}) : super(key: key);

  @override
  State<NotGivenVatScreen> createState() => _NotGivenVatScreenState();
}

class _NotGivenVatScreenState extends State<NotGivenVatScreen>
    with WidgetsBindingObserver {
  LC? a;
  late Box<LC?> _box;
  Chassis? selectedChassis;
  bool isSecondSegmentVisible = false;
  bool isEditable = false;
  List<Chassis> chassisList = [];
  List<Chassis> itemList =[];
  DateTime selectedDate = DateTime.now();
  int? selectedListTileIndex;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this as WidgetsBindingObserver);
    openBox();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this as WidgetsBindingObserver);
    // _box.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Close the box when the app is paused or the user leaves the page
      // _box.close();
    } else if (state == AppLifecycleState.resumed) {
      // Open the box when the app is resumed or the user enters the page
      openBox();
    }
  }

  Future<void> openBox() async {
    // _box = await Hive.openBox<LC?>('mboxo');

    searchUnsold(); // Call searchUnsold after _box is initialized
  }

  void searchUnsold() {
    List<Chassis> b = [];
    // List<LC?> matchingLCs = _box.values.toList();

    List<LC?> matchingLCs = Provider.of<Contents>(context,listen: false).postdata.toList();
    for (int i = 0; i < matchingLCs.length; i++) {
      List<Chassis> a = matchingLCs[i]!.chassis.toList();
      for (int j = 0; j < a.length; j++) {
        if (a[j].vat == 'Not Given') {
          b.add(a[j]);

        }
      }
    }
    setState(() {
      if (b.isNotEmpty) {
        chassisList = b;
        itemList = b;
      }
    });
    store();
  }

  int compareChassis(Chassis a, Chassis b) {
    final letterA = a.name.substring(0, 1).toUpperCase();
    final letterB = b.name.substring(0, 1).toUpperCase();

    // Define the letter hierarchy based on your requirement
    final letterHierarchy = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    final indexA = letterHierarchy.indexOf(letterA);
    final indexB = letterHierarchy.indexOf(letterB);

    // Compare the indices and return the comparison result
    return indexA.compareTo(indexB);
  }

  void store() {
    setState(() {

      // Create a new list by sorting the chassisList based on the name's first letter hierarchy
      List<Chassis> sortedChassisList = List<Chassis>.from(chassisList);
      sortedChassisList.sort(compareChassis);

      // Assign the sorted list to chassisList
      chassisList = sortedChassisList;
    });
  }

  void showSecondSegment(int index) {
    setState(() {
      selectedChassis = chassisList[index];
      isSecondSegmentVisible = true;
      a = findLCForChassis(selectedChassis!);
    });
  }

  LC? findLCForChassis(Chassis chassis) {
    // List<LC?> matchingLCs = _box.values.toList();
    List<LC?> matchingLCs = Provider.of<Contents>(context,listen: false).postdata.toList();
    for (int i = 0; i < matchingLCs.length; i++) {
      LC? lc = matchingLCs[i];
      if (lc!.chassis.contains(chassis)) {
        return lc;
      }
    }
    return null;
  }


  void hideSecondSegment() {
    setState(() {
      selectedChassis = null;
      isSecondSegmentVisible = false;
    });
  }

  void searchLC(String cNo) {
    String chassisNO = cNo.toLowerCase(); // Convert the search text to lowercase for case-insensitive comparison

    List<Chassis> matchingLCs = chassisNO==''||chassisNO==null?itemList:itemList.where((element) => element.chassis.toLowerCase().contains(chassisNO)).toList();
    setState(() {
      if (matchingLCs.isNotEmpty) {
        chassisList = matchingLCs;
        hideSecondSegment();
      }else{
        chassisList = itemList;
      }
    });
    store();
  }

  void searchCar(String cNo) {
    String chassisNO = cNo.toLowerCase(); // Convert the search text to lowercase for case-insensitive comparison

    List<Chassis> matchingLC = chassisNO==''||chassisNO==null?itemList:itemList.where((element) => element.name.toLowerCase().contains(chassisNO)).toList();
    setState(() {
      if (matchingLC.isNotEmpty) {
        chassisList = matchingLC;
        hideSecondSegment();
      }else if(matchingLC.isEmpty){
        chassisList = itemList;
      }else{
        chassisList = itemList;
      }
    });
    store();
  }


  String selectedSearchOption = 'Chassis No';
  TextEditingController cNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(
          HomePage.routeName,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('VAT Not Given'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight / 2),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: selectedSearchOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSearchOption = newValue!;
                              });
                            },
                            items: <String>['Vehicle Name', 'Chassis No'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Expanded(
                            child: TextField(
                              controller: cNoController,
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                suffixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                              onChanged: (value) {
                                selectedSearchOption=="Vehicle Name"?searchCar(value):searchLC(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        ),
        body: chassisList.isNotEmpty?Row(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: isSecondSegmentVisible
                      ? 1 * (w / 1336)
                      : 2.5 * ((w / 1336)),
                ),
                itemCount: chassisList.length,
                itemBuilder: (context, index) {
                  final chassis = chassisList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showSecondSegment(index);
                        selectedListTileIndex = index;
                      },
                      child: Card(
                        color: selectedListTileIndex == index ? Colors.amber.shade500 : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  chassis.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
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
                                          hideSecondSegment();
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
                                        items: <String>['Sold', 'Unsold','Booked'].map<DropdownMenuItem<String>>((String value) {
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
        ):Center(child: Text("No Data Found")),
      ),
    );
  }
}
