import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/choices.dart' as choices;
import 'package:myalice/utils/routes.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final globalKey = GlobalKey<ScaffoldState>();
  String _ticketType = 'Pending Tickets';
  bool _pendingSelected = true;
  bool _resolvedSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        /* AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Live Chat',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 25,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 16.0,
              ),
            ),
          ],
          bottom: PreferredSize(
              child: InboxAppBarBottomSection(),
              preferredSize: Size.fromHeight(40.0)),
        ), */
        body: Container(
            child: Column(children: [
          Container(
            height: 160,
            child: Stack(children: <Widget>[
              Container(
                // Background
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://picsum.photos/250?image=9"),
                        radius: 20.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Live Chat",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              globalKey.currentState!
                                  .showBottomSheet((BuildContext context) {
                                return Container(
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(_ticketType),
                                          leading:
                                              Icon(Icons.check_circle_outline,color: Colors.black),
                                          minLeadingWidth: 0.0,
                                          onTap: () {
                                            setState(() {
                                              _ticketType = "Resolve Tickets";
                                              _pendingSelected = true;
                                              _resolvedSelected = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          color: Colors.grey,
                                        ),
                                        ListTile(
                                          title: Text("Filter Tickets"),
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "assets/launch_icon/filter.svg",
                                              color: Colors.black
                                            ),
                                          ),
                                          minLeadingWidth: 0.0,
                                          onTap: () {
                                            setState(() {
                                              _ticketType = "Resolve Tickets";
                                              _pendingSelected = true;
                                              _resolvedSelected = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          color: Colors.grey,
                                        ),
                                        ListTile(
                                          title: Text("Filter Tickets"),
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "assets/launch_icon/descending.svg",
                                              color: Colors.black,
                                              height: 15,
                                            ),
                                          ),
                                          minLeadingWidth: 0.0,
                                          onTap: () {
                                            setState(() {
                                              _ticketType = "Resolve Tickets";
                                              _pendingSelected = true;
                                              _resolvedSelected = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }))
                  ],
                ),
                color: AliceColors.ALICE_GREEN,
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                // To take AppBar Size only
                top: 100.0,
                left: 20.0,
                right: 20.0,
                child: AppBar(
                  toolbarHeight: 50,
                  backgroundColor: Colors.white,
                  leading: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  primary: false,
                  title: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                ),
              )
            ]),
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(""),
                                      radius: 25,
                                    ),
                                    Positioned(
                                        top: 30,
                                        left: 30,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://picsum.photos/250?image=9"),
                                          radius: 10,
                                        ))
                                  ],
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Jorge Webb",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.facebook,
                                            color: AliceColors.ALICE_BLUE,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Welcome .........")
                                    ],
                                  ),
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '5 mins ago',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AliceColors.ALICE_GREEN,
                                          radius: 5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.lock,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                          onTap: () => Get.toNamed(CHAT_DETAILS_PAGE),
                        ));
                  },
                  itemCount: 10))
        ])));
  }
}
