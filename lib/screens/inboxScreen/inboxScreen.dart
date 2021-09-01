import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/mainModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/modals.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/profileImage.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/tickets.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final _inboxBottomSheet = GlobalKey<ScaffoldState>();

  late InboxController _inboxController;
  late String ticketType;
  late bool pendingSelected;
  late bool resolvedSelected;
  late bool channelSelected;
  late bool sortNew;
  final SharedPref _sharedPref = SharedPref();

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
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  isDismissible: true,
                                  builder: (context) {
                                    return MainModal(
                                      inboxController: _inboxController,
                                      pendingSelected: pendingSelected,
                                      resolvedSelected: resolvedSelected,
                                      sortNew: sortNew,
                                      onChanged: (bool pendingSelected,
                                          bool resolvedSelected, bool sortNew) {
                                        this.pendingSelected = pendingSelected;
                                        this.resolvedSelected =
                                            resolvedSelected;
                                        this.sortNew = sortNew;
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
}
