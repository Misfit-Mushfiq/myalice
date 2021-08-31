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
import 'package:myalice/screens/inboxScreen/customWidgets/modals.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/profileImage.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/tickets.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final _inboxBottomSheet = GlobalKey<ScaffoldState>();

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
                              CustomModals().showInboxModal(context, Get.find<InboxController>());
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
