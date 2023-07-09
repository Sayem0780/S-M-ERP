import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:printing/printing.dart';
import 'package:smerp/models/pdf_models/pdf_quotation.dart';
import 'package:smerp/widgets/method.dart';

import '../../widgets/search.dart';

class QuotationReport extends StatefulWidget {
  static const routeName="/quotationReport";
  const QuotationReport({Key? key}) : super(key: key);

  @override
  State<QuotationReport> createState() => _QuotationReportState();
}

class _QuotationReportState extends State<QuotationReport>  with WidgetsBindingObserver{
  @override
  late Box<Quotation?> _box;
  bool isSecondSegmentVisible = false;
  Quotation? selectedReport;
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

  List<Quotation?> customDataList =[];
  List<Quotation?> itemList =[];
  Future<void> openBox() async {
    _box = await Hive.openBox<Quotation?>('quotatioBox'); // Call searchUnsold after _box is initialized
    setState(() {
      customDataList = _box.values.toList();
      itemList=_box.values.toList();
    });


  }
  void searchChassis(String cNo) {
    String chassisNO = cNo.toLowerCase(); // Convert the search text to lowercase for case-insensitive comparison

    List<Quotation?> matchingLCs = customDataList.where((element) => element!.a.chassis.toLowerCase().contains(chassisNO)).toList();
    setState(() {
      if (matchingLCs.isNotEmpty) {
        customDataList = matchingLCs;
      }else{
        customDataList = itemList;
      }
    });
  }
  TextEditingController cNoController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quotation Report"),centerTitle: true,),
      body: Container(
        child: customDataList.isNotEmpty?Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
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
                          Quotation? customData = customDataList[index];
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
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Vehicle Name: ${customData!.a.name}'),
                                    Text('Chassis No: ${customData!.a.chassis}'),
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
                  build: (format) => quotationPdf(
                      selectedReport!.a,t: selectedReport?.intro??"",
                      ac:selectedReport?.ac??"",price: selectedReport?.price??"",
                      fit: selectedReport?.fittings??"",val: selectedReport?.validity??"",
                      method: selectedReport?.payment_method??"",qcode: selectedReport?.qcode??"",
                      currentDate: selectedReport?.currentDate??""),
                )),
              )
            ],
          ),
        ):Text("No Data Found"),
      )
      ,
    );
  }
}
