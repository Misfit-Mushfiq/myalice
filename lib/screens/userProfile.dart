import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/utils/colors.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool active_show = false;
  bool _pushNotification = false;
  bool _incomingTickets = false;
  bool _incomingMesaage = false;
  late UserInfoResponse _userInfoResponse;

  @override
  void initState() {
    super.initState();
    _userInfoResponse = Get.arguments;
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
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          _userInfoResponse.dataSource!.avatar!),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _userInfoResponse.dataSource!.fullName!,
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: AliceColors.ALICE_GREY,
                            padding: EdgeInsets.all(2.0),
                            elevation: 1.0),
                        child: Text(
                          "Team",
                          style: TextStyle(color: Colors.black),
                        )),
                    Text(_userInfoResponse.dataSource!.email!),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///PRIVACY///
                        Text(
                          "PRIVACY",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.notifications_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Notifications",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            showModal(context);
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
                              Icon(Icons.person_outline_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Show when active",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              CupertinoSwitch(
                                activeColor: AliceColors.ALICE_GREEN,
                                onChanged: (bool value) {
                                  setState(() {
                                    active_show = value;
                                  });
                                },
                                value: active_show,
                              )
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        ///MORE///
                        Text(
                          "MORE",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.menu_book_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Terms & Conditions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
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
                              Icon(Icons.comment_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Help & Support",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
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
                              Icon(Icons.article_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Documentation",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
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
                              Icon(Icons.info_outline_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("About this app",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Text(
                                "Version 1.0.10",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
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
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextButton(
                          child: Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Push Notification"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _pushNotification,
                                valueChanged: (value) {
                                  _pushNotification = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Incoming Ticket"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _incomingTickets,
                                valueChanged: (value) {
                                  _incomingTickets = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Incoming Message"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _incomingMesaage,
                                valueChanged: (value) {
                                  _incomingMesaage = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
