import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/projectsModels/projects.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/mainModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/profileImage.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/tickets.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final _inboxBottomSheet = GlobalKey<ScaffoldState>();

  late InboxController _inboxController;
  late bool pendingSelected;
  late bool resolvedSelected;
  late bool channelSelected;
  late bool sortNew;
  final SharedPref _sharedPref = SharedPref();
  late Projects _projects;

  var ticketType = "PENDING TICKETS".obs;

  @override
  void initState() {
    super.initState();
    _inboxController = Get.put(InboxController());
    readFilterParams();
  }

  void readFilterParams() async {
    pendingSelected = await _sharedPref.readBool("pendingSelected") ?? true;
    resolvedSelected = await _sharedPref.readBool("resolvedSelected") ?? false;
    sortNew = await _sharedPref.readBool('sortNew') ?? false;
    _projects = (await _inboxController.getProjects())!;
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Stack(children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 8.0, 8.0),
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
                        padding: const EdgeInsets.all(0.0),
                        child: GestureDetector(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  isDismissible: true,
                                  builder: (context) {
                                    return MainModal(
                                      inboxController:
                                          Get.find<InboxController>(),
                                      selectedChannels: _projects.dataSource!,
                                      pendingSelected: pendingSelected,
                                      resolvedSelected: resolvedSelected,
                                      sortNew: sortNew,
                                      onChanged: (bool pendingSelected,
                                          bool resolvedSelected, bool sortNew) {
                                        this.pendingSelected = pendingSelected;
                                        this.resolvedSelected =
                                            resolvedSelected;
                                        this.sortNew = sortNew;
                                        pendingSelected
                                            ? ticketType.value =
                                                "PENDING TICKETS"
                                            : ticketType.value =
                                                "RESOLVED TICKETS";
                                      },
                                    );
                                  }).whenComplete(() {
                                _sharedPref.saveBool(
                                    "pendingSelected", pendingSelected);
                                _sharedPref.saveBool(
                                    "resolvedSelected", resolvedSelected);
                                _sharedPref.saveBool("sortNew", sortNew);
                              });
                            }))
                  ],
                ),
                color: AliceColors.ALICE_GREEN,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                // To take AppBar Size only
                top: MediaQuery.of(context).size.height * 0.12,
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
                  leadingWidth: 40,
                  primary: false,
                  titleSpacing: 0.0,
                  centerTitle: false,
                  title: TextField(
                      onChanged: (String text) {
                        _inboxController
                            .getTickets(sortNew ? "desc" : "",
                                resolvedSelected ? 1 : 0, text)
                            .whenComplete(() {
                          setState(() {});
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Search Here",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                ),
              )
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0, top: 15, bottom: 5),
            child: Obx(() {
              return Text(ticketType.value,
                  style: TextStyle(color: Colors.grey, fontSize: 10,fontWeight: FontWeight.bold));
            }),
          ),
          Tickets()
        ])));
  }
}
