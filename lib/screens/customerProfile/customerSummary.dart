import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/models/responseModels/customerSummary/customer_summary.dart';

class CustomerSummaryScreen extends StatefulWidget {
  CustomerSummaryScreen({Key? key}) : super(key: key);

  @override
  _CustomerSummaryState createState() => _CustomerSummaryState();
}

class _CustomerSummaryState extends State<CustomerSummaryScreen> {
  CustomerProfileController _controller = Get.find<CustomerProfileController>();
  late CustomerSummary _customerSummary;
  late var _id;
  var _dataAvailable = false.obs;
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var _args = Get.arguments;
    _id = _args[0];
    _customerSummary = await _controller
        .getCustomerSummary(customerID: _id.toString())
        .then((value) {
      if (value!.success!) {
        setState(() {
          _dataAvailable.value = true;
        });
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer Summary",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            )),
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(() {
              if (_dataAvailable.value) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Lifetime Value",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${format.currencySymbol}" +
                                  _customerSummary.dataSource!.lifetimeValue
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Orders",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  _customerSummary.dataSource!.totalOrders
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Orders",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[700]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Average Order Value",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${format.currencySymbol}" +
                                  _customerSummary.dataSource!.averageValue
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Frequency",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                      _customerSummary.dataSource!.frequencyDays
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Days",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[700]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                        height: 25,
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(Icons.people_outlined),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Visits",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        _customerSummary.dataSource!.totalVisits
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              width: 1,
                              height: 50,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.indigo[50],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(Icons.chat_bubble_outline),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Tickets",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        _customerSummary
                                            .dataSource!.totalTickets
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ));
              }
            }),
          )),
    );
  }
}
