import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/customer.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/platform_icon.dart';
import 'package:myalice/utils/routes.dart';

class CustomerProfile extends StatefulWidget {
  CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  late Customer _customer;
    CustomerProfileController _controller = Get.put(CustomerProfileController());
  @override
  void initState() {
    var _args = Get.arguments;
    _customer = _args[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(_customer.avatar),
                      radius: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _customer.fullName!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              platformIcon(_customer.platform!.type!),
                              size: 15,
                              color: platformColor(_customer.platform!.type!),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              _customer.platform!.name!,
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: AliceColors.ALICE_GREY),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text("Customer Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              Icon(
                                (Icons.arrow_forward_ios),
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          onTap: () {
                            Get.toNamed(CUSTOMER_INFO_PAGE,
                                arguments: [_customer]);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text("Order History",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              Icon(
                                (Icons.arrow_forward_ios),
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text("Customer Summary",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              Icon(
                                (Icons.arrow_forward_ios),
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text("Product Interaction",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              Icon(
                                (Icons.arrow_forward_ios),
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
