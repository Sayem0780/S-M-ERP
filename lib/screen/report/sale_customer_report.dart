import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:printing/printing.dart';
import 'package:smerp/models/pdf_models/pdf_sale_customer.dart';
import '../../methods/pdf_method.dart';
import '../../widgets/search.dart';

class SaleCustomerReport extends StatefulWidget {
  static const routeName="/customer_sale_report";
  const SaleCustomerReport({Key? key}) : super(key: key);

  @override
  State<SaleCustomerReport> createState() => _SaleCustomerReportState();
}

class _SaleCustomerReportState extends State<SaleCustomerReport>  with WidgetsBindingObserver{
  late Box<SaleCustom?> _box;
  bool isSecondSegmentVisible = false;
  SaleCustom? selectedReport;
  int? selectedListTileIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    openBox();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  List<SaleCustom?> customDataList =[];
  List<SaleCustom?> itemList =[];
  Future<void> openBox() async {
    _box = await Hive.openBox<SaleCustom?>('salecustomBox'); // Call searchUnsold after _box is initialized
    setState(() {
      customDataList = _box.values.toList();
      itemList=_box.values.toList();
    });


  }
  void searchChassis(String cNo) {
    String chassisNO = cNo.toLowerCase(); // Convert the search text to lowercase for case-insensitive comparison

    List<SaleCustom?> matchingLCs = customDataList.where((element) => element!.a.chassis.toLowerCase().contains(chassisNO)).toList();
    setState(() {
      if (matchingLCs.isNotEmpty) {
        customDataList = matchingLCs;
      }else{
        customDataList = itemList;
      }
    });
  }
  TextEditingController cNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Receipt"),centerTitle: true,),
      body: Container(
        child: customDataList.isNotEmpty?Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    SearchWidget(cNoController: cNoController, searchChassis: searchChassis),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isSecondSegmentVisible?3:6, // Adjust the number of columns as needed
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2.0,
                        ),
                        itemCount: customDataList.length,
                        itemBuilder: (context, index) {
                          SaleCustom? customData = customDataList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedReport = customDataList[index];
                                isSecondSegmentVisible = true;
                                selectedListTileIndex = index;
                              });
                            },
                            child: Card(
                              color: selectedListTileIndex == index ? Colors.amber.shade500 : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Chassis NO: ${customData!.a.name}'),
                                    Text('Delivery Date: ${customData.a.chassis}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isSecondSegmentVisible,
                child: Expanded(child: PdfPreview(
                  build: (format) => SalecustomerPdf(selectedReport!.a,name: selectedReport?.name??"",price: selectedReport?.price??"",address: selectedReport?.address??"",phone: selectedReport?.phone??"",cpaid: selectedReport?.customerPay??"",inWord: selectedReport?.inWord??"",balance: selectedReport?.balance??"",currentDate:selectedReport?.currentDate??"",bank: selectedReport?.bank??"",branch: selectedReport?.branch??"",cheque:selectedReport?.cheque??"" ,tyre: selectedReport?.tyre??""),
                )),
              )
            ],
          ),
        ):const Text("No Data Found"),
      )
      ,
    );
  }
}
