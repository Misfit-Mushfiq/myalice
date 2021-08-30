import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/screens/chatDetails.dart';
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
  bool _channelSelected = false;
  bool _sortNew = false;
  late InboxController _inboxController;

  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Object?> _selectedAnimals2 = [];

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
            height: 350,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          Get.back();
                          showModal2(context, Get.find<InboxController>());
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      "Filter Options",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text(
                    "Channels",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    showFilterModal(context);
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text("Time", style: TextStyle(fontSize: 14)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text("Assigned Agent/Group",
                      style: TextStyle(fontSize: 14)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text(
                    "Tags",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void showFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text("Channels"),
                      ),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Reset",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _animals.add(Animal(id: 4, name: "Lionss"));
                            });
                          }),
                          
                          
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10.0),
                            child: MultiSelectChipField(
                              items: _items,
                              showHeader: false,
                              selectedChipColor: AliceColors.ALICE_SELECTED_CHANNEL,
                              height: 50,
                              
                              initialValue: _selectedAnimals2,
                              chipShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              decoration: BoxDecoration(),
                              /* itemBuilder: (item, state) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _channelSelected = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        color: _channelSelected
                                            ? AliceColors.ALICE_SELECTED_CHANNEL
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            size: 15,
                                          ),
                                          Text(
                                            " " + item.label,
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                               */onTap: (values) {
                                _selectedAnimals2 = values;
                              },
                              icon: Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /* _selectedAnimals2.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "None selected",
                                        style: TextStyle(color: Colors.black54),
                                      ))
                                  : MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedAnimals2.remove(value);
                                    });
                                  },
                                ), */
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  void showModal2(BuildContext context, InboxController controller) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isDismissible: true,
        builder: (context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      _pendingSelected
                          ? " Resolved Tickets"
                          : " Pending Tickets",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      _pendingSelected
                          ? Icons.check_circle_outline
                          : Icons.lock_clock,
                      color: Colors.black,
                      size: 25,
                    ),
                    minLeadingWidth: 0.0,
                    contentPadding: EdgeInsets.only(left: 10.0),
                    onTap: () {
                      setState(() {
                        _pendingSelected = !_pendingSelected;
                        _resolvedSelected = !_resolvedSelected;
                        controller.isticketsDataAvailable.value = false;
                        _resolvedSelected
                            ? controller.resolved = 1
                            : controller.resolved = 0;
                        controller.getTickets(
                            controller.sort, controller.resolved);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    title: Text(
                      "Filter Tickets",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/launch_icon/filter.svg",
                          color: Colors.black, height: 15),
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
                    contentPadding: EdgeInsets.only(left: 10.0),
                    title: _sortNew
                        ? Text(
                            "Sort by newest",
                            style: TextStyle(fontSize: 14),
                          )
                        : Text(
                            "Sort by oldest",
                            style: TextStyle(fontSize: 14),
                          ),
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
                      Get.back();
                      setState(() {
                        _sortNew = !_sortNew;
                        controller.isticketsDataAvailable.value = false;
                        _sortNew
                            ? controller.sort = "asc"
                            : controller.sort = "desc";
                        controller.getTickets(
                            controller.sort, controller.resolved);
                      });
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
                                          width: 8,
                                        ),
                                        FaIcon(
                                          platformIcon(controller
                                              .tickets.dataSource!
                                              .elementAt(index)
                                              .customer!
                                              .platform!
                                              .type!),
                                          size: 15,
                                          color: platformColor(controller
                                              .tickets.dataSource!
                                              .elementAt(index)
                                              .customer!
                                              .platform!
                                              .type!),
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
                                    readTimestamp(int.parse(controller
                                        .tickets.dataSource!
                                        .elementAt(index)
                                        .createdAt!)),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
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

  IconData platformIcon(String name) {
    switch (name) {
      case "whatsapp_messenger":
        return FontAwesomeIcons.whatsapp;
      case "facebook_messenger":
        return FontAwesomeIcons.facebookMessenger;
      case "viber_messenger":
        return FontAwesomeIcons.viber;
      case "line_messenger":
        return FontAwesomeIcons.line;
      case "facebook":
        return FontAwesomeIcons.facebook;
      case "telegram_messenger":
        return FontAwesomeIcons.telegram;
      default:
        return FontAwesomeIcons.info;
    }
  }

  Color platformColor(String name) {
    switch (name) {
      case "whatsapp_messenger":
        return AliceColors.ALICE_GREEN;
      case "facebook_messenger":
        return AliceColors.ALICE_BLUE;
      case "viber_messenger":
        return AliceColors.ALICE_VIBER;
      case "line_messenger":
        return AliceColors.ALICE_GREEN;
      case "facebook":
        return AliceColors.ALICE_GREEN;
      case "telegram_messenger":
        return AliceColors.ALICE_BLUE;
      default:
        return AliceColors.ALICE_BLUE;
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
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
