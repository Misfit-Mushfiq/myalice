import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/platform_icon.dart';
import 'package:myalice/utils/readTimeStamp.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';

class Tickets extends StatefulWidget {
  final Tags? availableTags;
  final AvailableAgents? agents;
  final AvailableGroups? groups;
  final CannedResponse? cannedResponse;
  final Function onRefresh;
  Tickets(
      {Key? key,
      required this.availableTags,
      required this.agents,
      required this.groups,
      required this.cannedResponse,
      required this.onRefresh})
      : super(key: key);

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InboxController _inboxController = Get.put(InboxController());
    return Obx(() {
      return _inboxController.ticketDataAvailable
          ? _inboxController.ticketResponse.value.dataSource!.length > 0
              ? Expanded(
                  child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        SharedPref().saveString(
                            "selectedInboxTags${_inboxController.ticketResponse.value.dataSource!.elementAt(index).id.toString()}",
                            TagsDataSource.encode(_inboxController
                                .ticketResponse.value.dataSource!
                                .elementAt(index)
                                .tags!));
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              _inboxController.ticketResponse
                                                      .value.dataSource!
                                                      .elementAt(index)
                                                      .customer!
                                                      .avatar ??
                                                  ""),
                                          radius: 25,
                                        ),
                                        Positioned(
                                            top: 30,
                                            left: 30,
                                            child: _inboxController
                                                        .ticketResponse
                                                        .value
                                                        .dataSource!
                                                        .elementAt(index)
                                                        .agents!
                                                        .length >
                                                    0
                                                ? CircleAvatar(
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          _inboxController
                                                                  .ticketResponse
                                                                  .value
                                                                  .dataSource!
                                                                  .elementAt(
                                                                      index)
                                                                  .agents!
                                                                  .elementAt(0)
                                                                  .avatar ??
                                                              ""),
                                                      radius: 8,
                                                    ),
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.white,
                                                  )
                                                : Container())
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
                                                _inboxController.ticketResponse
                                                    .value.dataSource!
                                                    .elementAt(index)
                                                    .customer!
                                                    .fullName!,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              FaIcon(
                                                platformIcon(_inboxController
                                                    .ticketResponse
                                                    .value
                                                    .dataSource!
                                                    .elementAt(index)
                                                    .customer!
                                                    .platform!
                                                    .type!),
                                                size: 15,
                                                color: platformColor(
                                                    _inboxController
                                                        .ticketResponse
                                                        .value
                                                        .dataSource!
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
                                            _inboxController.ticketResponse
                                                .value.dataSource!
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          readTimestamp(int.parse(
                                              _inboxController.ticketResponse
                                                  .value.dataSource!
                                                  .elementAt(index)
                                                  .createdAt!)),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: _inboxController
                                                      .ticketResponse
                                                      .value
                                                      .dataSource!
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
                                              _inboxController.ticketResponse
                                                      .value.dataSource!
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
                                onTap: () {
                                  Get.toNamed(CHAT_DETAILS_PAGE, arguments: [
                                    widget.availableTags,
                                    _inboxController
                                        .ticketResponse.value.dataSource!
                                        .elementAt(index)
                                        .id,
                                    _inboxController
                                        .ticketResponse.value.dataSource!
                                        .elementAt(index)
                                        .customer,
                                    widget.agents,
                                    _inboxController
                                        .ticketResponse.value.dataSource!
                                        .elementAt(index)
                                        .agents,
                                    widget.cannedResponse,
                                    _inboxController
                                        .ticketResponse.value.dataSource!
                                        .elementAt(index)
                                        .tags,
                                    widget.groups
                                  ]);
                                }));
                      },
                      itemCount: _inboxController
                          .ticketResponse.value.dataSource!.length),
                ))
              : Center(
                  child: Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.copy,
                            size: 150,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("No Tickets Found!"),
                          )
                        ],
                      ),
                    ),
                  ),
                )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            );
    });
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    widget.onRefresh();
  }
}
