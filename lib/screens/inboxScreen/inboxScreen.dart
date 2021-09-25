import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
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

  List<String>? _selectedAgentsID = [];
  List<String>? _selectedChannelsID = [];
  List<String>? _selectedTagsID = [];
  List<String>? _selectedTimes = [];
  List<String>? _selectedGroupsID = [];

  var ticketType = "PENDING TICKETS".obs;

  @override
  void initState() {
    super.initState();
    _inboxController = Get.put(InboxController());
    _inboxController.onInit();
    readFilterParams();
  }

  void readFilterParams() async {
    pendingSelected = await _sharedPref.readBool("pendingSelected") ?? true;
    resolvedSelected = await _sharedPref.readBool("resolvedSelected") ?? false;
    sortNew = await _sharedPref.readBool('sortNew') ?? false;

    _selectedChannelsID =
        await _sharedPref.readStringList("selectedChannelsID") ?? [];
    _selectedAgentsID =
        (await _sharedPref.readStringList("selectedAgentsID")) ?? [];
    _selectedTagsID =
        (await _sharedPref.readStringList("selectedTagsID")) ?? [];
    _selectedTimes = await _sharedPref.readStringList("selectedTimes") ?? [];
    _selectedGroupsID =
        await _sharedPref.readStringList("selectedGroupsID") ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
        key: _inboxBottomSheet,
        body: Container(
          color: Colors.white,
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
                              showCupertinoModalBottomSheet(
                                      context: context,
                                      useRootNavigator: true,
                                      expand: false,
                                      isDismissible: true,
                                      
                                      builder: (context) {
                                        return MainModal(
                                          channels: _inboxController.channels,
                                          agents: _inboxController.agents,
                                          groups: _inboxController.groups,
                                          tags: _inboxController.tags,
                                          inboxController:
                                              Get.find<InboxController>(),
                                          pendingSelected: pendingSelected,
                                          resolvedSelected: resolvedSelected,
                                          sortNew: sortNew,
                                          onChanged: (bool pendingSelected,
                                              bool resolvedSelected,
                                              bool sortNew) {
                                            this.pendingSelected =
                                                pendingSelected;
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
                                      })
                                  .then((value) => print(value))
                                  .whenComplete(() {
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
                  elevation: 1.0,
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
                        Get.find<InboxController>()
                            .getTickets(
                                projectID: _inboxController.projectID,
                                order: sortNew ? "desc" : "",
                                resolved: resolvedSelected ? 1 : 0,
                                search: text,
                                channels: _selectedChannelsID!,
                                agents: _selectedAgentsID!,
                                groups: _selectedGroupsID!,
                                tags: _selectedTagsID!,
                                dates: _selectedTimes!)
                            .catchError((e) {})
                            .then((value) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            //setState(() {});
                          });
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
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold));
            }),
          ),
          Obx(() {
            if (_inboxController.tagsAvailable &&
                _inboxController.cannedResponseAvailable &&
                _inboxController.ticketDataAvailable) {
              return Expanded(
                child: Tickets(
                  availableTags: _inboxController.tags,
                  agents: _inboxController.agents,
                  groups: _inboxController.groups,
                  cannedResponse: _inboxController.cannedResponse,
                  onRefresh: () {
                    setState(() {});
                  },
                ),
              );
            } else {
              return Container();
            }
          })
        ])));
  }
}
