import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';

import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final _inboxBottomSheet = GlobalKey<ScaffoldState>();
  String _ticketType = 'Pending Tickets';
  bool _pendingSelected = true;
  bool _resolvedSelected = false;
  late InboxController _inboxController;
  @override
  void initState() {
    super.initState();
    _inboxController = Get.put(InboxController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _inboxBottomSheet,
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
            height: MediaQuery.of(context).size.height * 0.18,
            child: Stack(children: <Widget>[
              Container(
                // Background
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                      child: GestureDetector(child: ProfileImage()),
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
                              showModal2(context, Get.find<InboxController>());
                            }))
                  ],
                ),
                color: AliceColors.ALICE_GREEN,
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                // To take AppBar Size only
                top: MediaQuery.of(context).size.height * 0.11,
                left: 10.0,
                right: 10.0,
                child: AppBar(
                  toolbarHeight: 40,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
                  leading: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  primary: false,
                  titleSpacing: 0.0,
                  centerTitle: false,
                  title: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                ),
              )
            ]),
          ),
          Tickets()
        ])));
  }

  void showModal1(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          showModal2(context, Get.find<InboxController>());
                        },
                        icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                ListTile(
                  title: Text(_ticketType),
                  leading:
                      Icon(Icons.check_circle_outline, color: Colors.black),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  void showModal2(BuildContext context, InboxController controller) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(_resolvedSelected
                        ? "Resolve Tickets"
                        : "Pending Tickets"),
                    leading:
                        Icon(Icons.check_circle_outline, color: Colors.black),
                    minLeadingWidth: 0.0,
                    onTap: () {
                      setState(() {
                        _pendingSelected = !_pendingSelected;
                        _resolvedSelected = !_resolvedSelected;
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
                      child: SvgPicture.asset("assets/launch_icon/filter.svg",
                          color: Colors.black),
                    ),
                    minLeadingWidth: 0.0,
                    onTap: () {
                      Get.back();
                      showModal1(context);
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text("Sort by newest"),
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
                        controller.sort = "asc";
                        controller.getTickets("asc");
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

class Tickets extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.ticketDataAvailable
          ? Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(controller
                                            .tickets.dataSource!
                                            .elementAt(index)
                                            .customer!
                                            .avatar ??
                                        ""),
                                    radius: 25,
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 30,
                                      child: controller.tickets.dataSource!
                                                  .elementAt(index)
                                                  .agents!
                                                  .length >
                                              0
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  controller.tickets.dataSource!
                                                      .elementAt(index)
                                                      .agents!
                                                      .elementAt(0)
                                                      .avatar!),
                                              radius: 10,
                                            )
                                          : Container())
                                ],
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          controller.tickets.dataSource!
                                              .elementAt(index)
                                              .customer!
                                              .fullName!,
                                          style: TextStyle(
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
                                    Text(
                                      controller.tickets.dataSource!
                                          .elementAt(index)
                                          .customer!
                                          .lastMessageText!,
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "5 mins ago"
                                    /* DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(controller
                                                    .tickets.dataSource!
                                                    .elementAt(index)
                                                    .createdAt!) *
                                                1000)).inDays
                                        .toString() */
                                    ,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: controller
                                                .tickets.dataSource!
                                                .elementAt(index)
                                                .isReplied!
                                            ? AliceColors.ALICE_GREEN
                                            : Colors.red,
                                        radius: 4,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        controller.tickets.dataSource!
                                                .elementAt(index)
                                                .isLocked!
                                            ? Icons.lock
                                            : Icons.lock_open_rounded,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          onTap: () => Get.toNamed(CHAT_DETAILS_PAGE),
                        ));
                  },
                  itemCount: controller.tickets.dataSource!.length))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            );
    });
  }
}

class ProfileImage extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.userDataAvailable
          ? GestureDetector(
              child: new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new CachedNetworkImageProvider(
                        controller.user.dataSource!.avatar!),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(USER_PROFILE_PAGE, arguments: controller.user);
              },
            )
          : CircularProgressIndicator();
    });
  }
}
