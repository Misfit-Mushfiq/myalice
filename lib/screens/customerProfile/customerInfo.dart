import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/customer.dart';
import 'package:myalice/utils/routes.dart';

class CustomerInfo extends StatefulWidget {
  CustomerInfo({Key? key}) : super(key: key);

  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  late Customer _customer;
  late Map _cusomerData;
  late var _fixedData = Map().obs;
  late var _variableData = Map().obs;
  CustomerProfileController _controller = Get.find<CustomerProfileController>();
  @override
  void initState() {
    super.initState();
    var _args = Get.arguments;
    _customer = _args[0];
    getMapdata();
  }

  getMapdata() async {
    _cusomerData =
        await _controller.getAttributeMap(customerID: _customer.id!.toString());
    setState(() {});
    _fixedData.value = _cusomerData["fixed"];
    _variableData.value = _cusomerData['variable'];
    _fixedData.removeWhere((key, value) {
      return key == "tags" ||
          key == "platform" ||
          key == "bot_enabled" ||
          key == "created_at" ||
          key == "avatar" ||
          key == "first_name" ||
          key == "id" ||
          key == "last_name" ||
          key == "primary_id";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Customer Information",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Alice ID: #${_customer.id}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("User attributes",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                        TextButton(
                            onPressed: () async {
                              var result = await Get.toNamed(CUSTOMER_INFO_EDIT,
                                  arguments: [
                                    _fixedData,
                                    _customer.id,
                                    _variableData
                                  ]);

                              if (result) {
                                getMapdata();
                              }
                            },
                            child: Text("Update"))
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Obx(() {
                    if (_fixedData.length > 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: _fixedData.length,
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              String key = _fixedData.keys.elementAt(index);
                              return Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              "${(key.capitalizeFirst)!.split("_").first} ",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ))),
                                      Expanded(
                                          child: new Text(
                                        "${_fixedData[key]}",
                                        textAlign: TextAlign.end,
                                      ))
                                    ],
                                  ));
                            }),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _variableData.length,
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String key = _variableData.keys.elementAt(index);
                          return Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                          "${(key.capitalizeFirst)!.split("_").first} ",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ))),
                                  Expanded(
                                      child: new Text(
                                    "${_variableData[key]}",
                                    textAlign: TextAlign.end,
                                  ))
                                ],
                              ));
                        }),
                  )
                ],
              ),
            )));
  }
}
