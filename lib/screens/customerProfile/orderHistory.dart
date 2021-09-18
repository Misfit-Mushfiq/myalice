import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/models/responseModels/customerOrder/customer_order_history.dart';
import 'package:myalice/models/responseModels/customerOrder/data_source.dart';
import 'package:myalice/utils/readTimeStamp.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  CustomerProfileController _controller = Get.find<CustomerProfileController>();
  late CustomerOrderHistory _orderHistory;
  late var _list = <OrderDataSource>[].obs;
  late var _id;
  var _itemsTotal = 0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var _args = Get.arguments;
    _id = _args[0];
    _orderHistory =
        await _controller.getOrderHistory(customerID: _id.toString());
    _list.value = _orderHistory.dataSource!;
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
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
            child: Column(
              children: [
                Obx(() {
                  if (_list.length > 0) {
                    return ListView.builder(
                        itemCount: _list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          _itemsTotal = 0;
                          for (var a in _list.elementAt(index).products!) {
                            _itemsTotal += a.totalCost!.toInt();
                          }
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Order #${_list.elementAt(index).ecommerceOrderId}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Text(
                                          "${format.currencySymbol}" +
                                              _list
                                                  .elementAt(index)
                                                  .totalCost
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getDateFromTimeStamp(int.parse(
                                          _list.elementAt(index).createdAt!)),
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Text("Unpaid",
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: _list
                                                          .elementAt(index)
                                                          .status ==
                                                      "cancelled"
                                                  ? Colors.red[100]
                                                  : Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Text(
                                              (_list.elementAt(index).status!)
                                                  .capitalizeFirst!,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: _list
                                                              .elementAt(index)
                                                              .status ==
                                                          "cancelled"
                                                      ? Colors.red[700]
                                                      : Colors.blue[700])),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Purchased Item:",
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                    Text(_list
                                        .elementAt(index)
                                        .products!
                                        .length
                                        .toString())
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text("Payment Method:",
                                            style: TextStyle(
                                                color: Colors.grey[700]))),
                                    Expanded(
                                        child: Text(
                                      _list.elementAt(index).paymentMethod!,
                                      textAlign: TextAlign.right,
                                    ))
                                  ],
                                ),
                                Divider(thickness: 1.5),
                                ExpandablePanel(
                                  theme: ExpandableThemeData(
                                      alignment: Alignment.topCenter,
                                      iconPlacement:
                                          ExpandablePanelIconPlacement.right,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      iconSize: 20,
                                      expandIcon: IconData(57415,
                                          fontFamily: 'MaterialIcons'),
                                      collapseIcon: IconData(58646,
                                          fontFamily: 'MaterialIcons')),
                                  header: Text("Summary"),
                                  collapsed: Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  ),
                                  expanded: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Billing Address",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: _list
                                                                .elementAt(
                                                                    index)
                                                                .billingAddress!
                                                                .addressOne
                                                                .toString()));
                                                    Get.snackbar("", "",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        titleText: Center(
                                                            child: Text(
                                                                "Copied")));
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 18,
                                                  ))
                                            ],
                                          ),
                                          Text(
                                              _list
                                                  .elementAt(index)
                                                  .billingAddress!
                                                  .addressOne
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              _list
                                                      .elementAt(index)
                                                      .billingAddress!
                                                      .addressTwo
                                                      .toString() +
                                                  (" (Optional)"),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              _list
                                                  .elementAt(index)
                                                  .billingAddress!
                                                  .country
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700]))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Shipping Address",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: _list
                                                                .elementAt(
                                                                    index)
                                                                .shippingAddress!
                                                                .addressOne
                                                                .toString()));
                                                    Get.snackbar("", "",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        titleText: Center(
                                                            child: Text(
                                                                "Copied")));
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 18,
                                                  ))
                                            ],
                                          ),
                                          Text(
                                              _list
                                                  .elementAt(index)
                                                  .shippingAddress!
                                                  .addressOne
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              _list
                                                      .elementAt(index)
                                                      .shippingAddress!
                                                      .addressTwo
                                                      .toString() +
                                                  (" (Optional)"),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              _list
                                                  .elementAt(index)
                                                  .shippingAddress!
                                                  .country
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700]))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Shipping Method",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: _list
                                                                .elementAt(
                                                                    index)
                                                                .shippingMethod!
                                                                .toString()));
                                                    Get.snackbar("", "",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        titleText: Center(
                                                            child: Text(
                                                                "Copied")));
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 18,
                                                  ))
                                            ],
                                          ),
                                          Text(
                                              _list
                                                  .elementAt(index)
                                                  .shippingMethod!
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1.5,
                                        height: 30,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Item's Total",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _itemsTotal.toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Tax",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _list
                                                            .elementAt(index)
                                                            .totalTax
                                                            .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Delivery Charge",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _list
                                                            .elementAt(index)
                                                            .totalShippingCost
                                                            .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Discount",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _list
                                                            .elementAt(index)
                                                            .totalDiscount
                                                            .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Total",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _list
                                                            .elementAt(index)
                                                            .totalCost
                                                            .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Refunded",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text(
                                                    "${format.currencySymbol}" +
                                                        _list
                                                            .elementAt(index)
                                                            .totalRefund
                                                            .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Net Payment",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 15)),
                                                Text("${format.currencySymbol}" +
                                                    (_list
                                                                .elementAt(
                                                                    index)
                                                                .totalCost! -
                                                            _list
                                                                .elementAt(
                                                                    index)
                                                                .totalRefund!)
                                                        .toString())
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(thickness: 1.5),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Coupon",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 15)),
                                      Text(_list
                                                  .elementAt(index)
                                                  .couponInfo!
                                                  .length <=
                                              0
                                          ? "Not Applicable"
                                          : "Not implemented")
                                    ],
                                  ),
                                ),
                                Divider(thickness: 1.5),
                                ExpandablePanel(
                                  theme: ExpandableThemeData(
                                      alignment: Alignment.topCenter,
                                      iconPlacement:
                                          ExpandablePanelIconPlacement.right,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      iconSize: 20,
                                      expandIcon: IconData(57415,
                                          fontFamily: 'MaterialIcons'),
                                      collapseIcon: IconData(58646,
                                          fontFamily: 'MaterialIcons')),
                                  header: Text("Products"),
                                  collapsed: Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  ),
                                  expanded: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: _list
                                                    .elementAt(index)
                                                    .products!
                                                    .length,
                                                itemBuilder: (context, indexs) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl: _list
                                                              .elementAt(index)
                                                              .products!
                                                              .elementAt(indexs)
                                                              .productImages!
                                                              .elementAt(0),
                                                          height: 60,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _list
                                                                  .elementAt(
                                                                      index)
                                                                  .products!
                                                                  .elementAt(
                                                                      indexs)
                                                                  .productName!,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Quantity : ${_list.elementAt(index).products!.elementAt(indexs).quantity}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                                _list
                                                                    .elementAt(
                                                                        index)
                                                                    .products!
                                                                    .elementAt(
                                                                        indexs)
                                                                    .sku!,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700])),
                                                          ],
                                                        )),
                                                        Text(
                                                            "${format.currencySymbol}" +
                                                                _list
                                                                    .elementAt(
                                                                        index)
                                                                    .products!
                                                                    .elementAt(
                                                                        indexs)
                                                                    .totalCost
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700]))
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                })
              ],
            ),
          )),
    );
  }
}
