import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/custom%20widgets/botButton.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class CustomerProfile extends StatefulWidget {
  CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
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
                      radius: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Richard Cooper",
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
                            Icon(
                              Icons.facebook,
                              color: AliceColors.ALICE_BLUE,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Online Customer Support",
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
                            Get.toNamed(CUSTOMER_INFO_PAGE);
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
