import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:smerp/lc/lc_report_screen.dart';
import 'package:smerp/models/chassis_model.dart';
import 'package:smerp/models/lc_model.dart';

class ChasisEntry extends StatefulWidget {
  static const routeName = '/chassis entry';

  const ChasisEntry({Key? key}) : super(key: key);

  @override
  State<ChasisEntry> createState() => _ChasisEntryState();
}

class _ChasisEntryState extends State<ChasisEntry> with WidgetsBindingObserver{
  final _formKey = GlobalKey<FormState>();
  bool saved=false;
  String vat = 'Not Given', sold = 'Unsold';
  String name = "",
      cc = "",
      chassis = "",
      engineNo = "",
      color = "",
      model = "",
      remark = "",
      km = "",
      deliver_date = "";
  double buying_price = 0,
      invoice = 0,
      tt_amount = 0,
      port_cost = 0,
      duty = 0,
      cnf = 0,
      warfrent = 0,
      others = 0;
  double total = 0,
      selling_price = 0,
      profit = 0,
      invoice_rate = 0,
      invoice_bdt = 0,
      tt_rate = 0,
      tt_bdt = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController chassisController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController buyingpriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController ttController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController dutyController = TextEditingController();
  TextEditingController cnfController = TextEditingController();
  TextEditingController warfrentController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController sellController = TextEditingController();
  TextEditingController profitController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController invoiceRateController = TextEditingController();
  TextEditingController ttRateController = TextEditingController();
  TextEditingController invoiceBDTController = TextEditingController();
  TextEditingController ttBDTController = TextEditingController();
  TextEditingController kmController = TextEditingController();
  TextEditingController deliverController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    ttController.text = tt_amount.toString();
    totalController.text = total.toString();
    invoiceBDTController.text = invoice_bdt.toString();
    ttBDTController.text = tt_bdt.toString();
    profitController.text = profit.toString();
    WidgetsBinding.instance.addObserver(this);
  }
  void updateTTAmount() {
    setState(() {
      tt_amount = buying_price - invoice;
      ttController.text = tt_amount.toString();
    });
  }
  void updateBeforeDuty() {
    setState(() {
      port_cost = invoice_bdt +  tt_bdt;
      portController.text = port_cost.toString();
    });
  }
  void updateTotal() {
    setState(() {
      total = port_cost + duty + cnf + warfrent + others;
      totalController.text = total.toString();
    });
  }
  void updateInvoice() {
    setState(() {
      invoice_bdt = invoice * invoice_rate;
      invoiceBDTController.text = invoice_bdt.toString();
    });
  }
  void updateTT() {
    setState(() {
      tt_bdt = tt_amount * tt_rate;
      ttBDTController.text = tt_bdt.toString();
    });
  }
  void updatelossProfit() {
    setState(() {
      profit = selling_price - total;
      profitController.text = profit.toString();
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        deliverController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        deliver_date = deliverController.text; // Assign the selected date to the 'date' variable
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();;
    chassisController.dispose();
    engineController.dispose();
    ccController.dispose();
    colorController.dispose();
    modelController.dispose();
    buyingpriceController.dispose();
    invoiceController.dispose();
    ttController.dispose();
    portController.dispose();
    dutyController.dispose();
    cnfController.dispose();
    warfrentController.dispose();
    otherController.dispose();
    totalController.dispose();
    sellController.dispose();
    profitController.dispose();
    remarkController.dispose();
    invoiceRateController.dispose();
    ttRateController.dispose();
    invoiceBDTController.dispose();
    ttBDTController.dispose();
    kmController.dispose();
    deliverController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void chassisAdd(Chassis car, int index) async{
    // print("under chassis add"+index.toString());
    Box box = await Hive.openBox<LC?>('mboxo');
    LC lc = box.getAt(index);
    lc.chassis.add(car);
    lc.save();
    box.put(lc.key, lc);

  }

  @override
  Widget build(BuildContext context) {
    int LcIndex = ModalRoute.of(context)!.settings.arguments as int;
    print(" Under Build "+LcIndex.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Chassis Entry'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: nameController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter Vehicle Name",
                                  labelText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  name = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Name Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //name
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: colorController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter Color",
                                  labelText: "Color",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  color = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Color Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //color
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: modelController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter model",
                                  labelText: "Model",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  model = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Model Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //model
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: chassisController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter Chassis No",
                                  labelText: "Chassis No",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  chassis = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Chassis No Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //chassis
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: engineController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter Engine No",
                                  labelText: "Engine No",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  engineNo = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Engine No Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //Engine No
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: ccController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter CC value",
                                  labelText: "CC",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  cc = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty ? 'CC Required' : null;
                                }),
                              ),
                            ),
                          ), //cc
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: kmController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter AP/KM",
                                  labelText: "AP/KM",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  km = value;
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'KM Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //AP/KM
                          Container(
                            width: 350,
                            child: TextFormField(
                              controller: deliverController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: "Landing date",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(onPressed: (){
                                  _selectDate(context);
                                }, icon: Icon(Icons.date_range)),
                              ),
                              validator: (value) {
                                setState(() {
                                  value = deliver_date;
                                });
                                return value==''? 'Select a date' : null;
                              },
                            ),
                          ), //Date
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: DropdownButtonFormField<String>(
                                      value: vat,
                                      onChanged: (String? newValue) { // Update the function signature
                                        if (newValue != null) {
                                          setState(() {
                                            vat = newValue; // Perform actions based on the selected value
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: "VAT",
                                        border: OutlineInputBorder(),
                                      ),
                                      items: <String>['Given', 'Not Given'].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ), //vat
                                Container(
                                  width: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: DropdownButtonFormField<String>(
                                      value: sold,
                                      onChanged: (String? newValue) { // Update the function signature
                                        if (newValue != null) {
                                          setState(() {
                                            sold = newValue; // Perform actions based on the selected value
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Sold",
                                        border: OutlineInputBorder(),
                                      ),
                                      items: <String>['Sold', 'Unsold','Booked'].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),//sold
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: buyingpriceController,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Enter buying Price",
                                  labelText: "'\$Buying Price",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  bool isDouble(String value) {
                                    try {
                                      double.parse(value);
                                      return true;
                                    } catch (e) {
                                      return false;
                                    }
                                  }
                                  value.isNotEmpty ? setState(() {
                                    if (isDouble(value)) {
                                      buying_price = double.parse(value);
                                    } else {
                                      buying_price = 0;
                                    }
                                  }) : setState(() {
                                    buying_price = 0;
                                  });
                                  updateTTAmount();
                                  updateTotal();
                                  updateBeforeDuty();
                                  updatelossProfit();
                                  updateInvoice();
                                  updateTT();
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Buying Price Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //buying price
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: invoiceController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Enter Invoice Price",
                                        labelText: "'\$Invoice",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        bool isDouble(String value) {
                                          try {
                                            double.parse(value);
                                            return true;
                                          } catch (e) {
                                            return false;
                                          }
                                        }
                                        value.isNotEmpty
                                            ? setState(() {
                                          if (isDouble(value)) {
                                            invoice = double.parse(value);
                                          } else {
                                            invoice = 0;
                                          }
                                        }) : setState(() {
                                          invoice = 0;
                                        });
                                        updateTTAmount();
                                        updateTotal();
                                        updateBeforeDuty();
                                        updatelossProfit();
                                        updateInvoice();
                                        updateTT();
                                      },
                                      validator: ((value) {
                                        return value!.isEmpty
                                            ? 'Invoice Required'
                                            : null;
                                      }),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: invoiceRateController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Invoice Rate",
                                        labelText: "Inovice Rate",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        bool isDouble(String value) {
                                          try {
                                            double.parse(value);
                                            return true;
                                          } catch (e) {
                                            return false;
                                          }
                                        }
                                        value.isNotEmpty
                                            ? setState(() {
                                          if (isDouble(value)) {
                                            invoice_rate = double.parse(value);
                                          } else {
                                            invoice_rate = 0;
                                          }
                                        }) : setState(() {
                                          invoice_rate = 0;
                                        });
                                        updateTTAmount();
                                        updateTotal();
                                        updateBeforeDuty();
                                        updatelossProfit();
                                        updateInvoice();
                                        updateTT();
                                      },
                                      validator: ((value) {
                                        return value!.isEmpty
                                            ? 'Invoice Rate Required'
                                            : null;
                                      }),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: invoiceBDTController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Invoice BDT",
                                        border: OutlineInputBorder(),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), //invoice
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: ttController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: "'\$ TT",
                                        border: OutlineInputBorder(),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: ttRateController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "TT Rate",
                                        labelText: "TT Rate",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        bool isDouble(String value) {
                                          try {
                                            double.parse(value);
                                            return true;
                                          } catch (e) {
                                            return false;
                                          }
                                        }
                                        value.isNotEmpty
                                            ? setState(() {
                                          if (isDouble(value)) {
                                            tt_rate = double.parse(value);
                                          } else {
                                            tt_rate = 0;
                                          }
                                        }) : setState(() {
                                          tt_rate = 0;
                                        });
                                        updateTTAmount();
                                        updateTotal();
                                        updateBeforeDuty();
                                        updatelossProfit();
                                        updateInvoice();
                                        updateTT();
                                      },
                                      validator: ((value) {
                                        return value!.isEmpty
                                            ? 'TT Rate Required'
                                            : null;
                                      }),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: ttBDTController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "TT BDT",
                                        border: OutlineInputBorder(),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), //TT AMount
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: portController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Cost Before Duty",
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                              ),
                            ),
                          ), //Port Cost
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: dutyController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter Duty Charge",
                                  labelText: "Duty",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  bool isDouble(String value) {
                                    try {
                                      double.parse(value);
                                      return true;
                                    } catch (e) {
                                      return false;
                                    }
                                  }
                                  value.isNotEmpty
                                      ? setState(() {
                                    if (isDouble(value)) {
                                      duty = double.parse(value);
                                    } else {
                                      duty = 0;
                                    }
                                  }) : setState(() {
                                    duty = 0;
                                  });
                                  updateTTAmount();
                                  updateTotal();
                                  updateBeforeDuty();
                                  updatelossProfit();
                                  updateInvoice();
                                  updateTT();
                                },
                                validator: ((value) {
                                  return value!.isEmpty
                                      ? 'Duty Charge Required'
                                      : null;
                                }),
                              ),
                            ),
                          ), //Duty
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: cnfController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter CNF Charge",
                                  labelText: "CNF",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String value) {
                                  bool isDouble(String value) {
                                    try {
                                      double.parse(value);
                                      return true;
                                    } catch (e) {
                                      return false;
                                    }
                                  }
                                  value.isNotEmpty
                                      ? setState(() {
                                    if (isDouble(value)) {
                                      cnf = double.parse(value);
                                    } else {
                                      cnf = 0;
                                    }
                                  }) : setState(() {
                                    cnf = 0;
                                  });
                                  updateTTAmount();
                                  updateTotal();
                                  updateBeforeDuty();
                                  updatelossProfit();
                                  updateInvoice();
                                  updateTT();
                                },
                                validator: ((value) {
                                  return value!.isEmpty ? 'CNF Required' : null;
                                }),
                              ),
                            ),
                          ), //CNF
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: warfrentController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Enter Warfrent Cost",
                                        labelText: "Warfrent",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        bool isDouble(String value) {
                                          try {
                                            double.parse(value);
                                            return true;
                                          } catch (e) {
                                            return false;
                                          }
                                        }
                                        value.isNotEmpty
                                            ? setState(() {
                                          if (isDouble(value)) {
                                            warfrent = double.parse(value);
                                          } else {
                                            warfrent = 0;
                                          }
                                        }) : setState(() {
                                          warfrent = 0;
                                        });
                                        updateTTAmount();
                                        updateTotal();
                                        updateBeforeDuty();
                                        updatelossProfit();
                                        updateInvoice();
                                        updateTT();
                                      },
                                      validator: ((value) {
                                        return value!.isEmpty
                                            ? 'Warfrent is Required'
                                            : null;
                                      }),
                                    ),
                                  ),
                                ), //warf rent
                                Container(
                                  width: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: otherController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Enter Other Charges",
                                        labelText: "Others",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) {
                                        bool isDouble(String value) {
                                          try {
                                            double.parse(value);
                                            return true;
                                          } catch (e) {
                                            return false;
                                          }
                                        }
                                        value.isNotEmpty
                                            ? setState(() {
                                          if (isDouble(value)) {
                                            others =
                                                double.parse(value);
                                          } else {
                                            others = 0;
                                          }
                                        }) : setState(() {
                                          others = 0;
                                        });
                                        updateTTAmount();
                                        updateTotal();
                                        updateBeforeDuty();
                                        updatelossProfit();
                                        updateInvoice();
                                        updateTT();
                                      },
                                    ),
                                  ),
                                ), //other
                              ],
                            ),
                          ), //Warf rent
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: TextFormField(
                                      controller: totalController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: "Total Cost",
                                        border: OutlineInputBorder(),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ), //Total Cost
                                Container(
                                  width: 170,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: TextFormField(
                                    controller: sellController,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Selling Price',
                                      labelText: "Selling Price",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (String value) {
                                      String value = sellController.text.trim();
                                      bool isDouble(String value) {
                                        try {
                                          double.parse(value);
                                          return true;
                                        } catch (e) {
                                          return false;
                                        }
                                      }
                                      value.isNotEmpty
                                          ? setState(() {
                                              if (isDouble(value)) {
                                                selling_price =
                                                    double.parse(value);
                                              } else {
                                                selling_price = 0;
                                              }
                                            })
                                          : setState(() {
                                              selling_price = 0;
                                            });
                                      updateTTAmount();
                                      updateTotal();
                                      updateBeforeDuty();
                                      updatelossProfit();
                                      updateInvoice();
                                      updateTT();
                                    },
                                  ),
                                ), //Selling Price
                              ],
                            ),
                          ), //Total
                          Container(
                            width: 350,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                controller: profitController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Profit/Loss",
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                              ),
                            ),
                          ), //Profit
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 40),
                        child: TextFormField(
                          controller: remarkController,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Enter Others cost details",
                            labelText: "Remarks",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              remark = value;
                            });
                          },
                        ),
                      ) //Remarks
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   chassisAdd(Chassis(
                     name: name,
                     cc: cc,
                     chassis: chassis,
                     engineNo: engineNo,
                     color: color,
                     model: model,
                     remark: remark,
                     buyingPrice: buying_price,
                     invoice: invoice,
                     ttAmount: tt_amount,
                     portCost: port_cost,
                     duty: duty,
                     cnf: cnf,
                     warfrent: warfrent,
                     others: others,
                     total: total,
                     sellingPrice: selling_price,
                     profit: profit,
                     invoiceRate: invoice_rate,
                     invoiceBdt: invoice_bdt,
                     ttRate: tt_rate,
                     ttBdt: tt_bdt,
                     delivery_date: deliver_date,
                     sold: sold,
                     km: km,
                     vat: vat,
                   ), LcIndex);
                   Navigator.of(context).pushNamed(LcReportScreen.routeName,arguments: LcIndex as int);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Chassis Not Stored'),
                          content:
                              Text('The chassis is not stored in the box.'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                color: Colors.amber,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

