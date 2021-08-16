import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool active_show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
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
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Team",
                          style: TextStyle(color: Colors.black),
                        )),
                    Text("richard.cooper@example.com"),
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
                              Icon((Icons.arrow_forward_ios))
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
                              Icon((Icons.arrow_forward_ios))
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
                              Icon((Icons.arrow_forward_ios))
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
                              Icon((Icons.arrow_forward_ios))
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
                              Icon((Icons.arrow_forward_ios))
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
                SizedBox(height:100),
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
}
