import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/platform_icon.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';

class Tickets extends StatefulWidget {
  final Tags? availableTags;
  final AvailableAgents? agents;
  final CannedResponse? cannedResponse;
  final Function onRefresh;
  Tickets(
      {Key? key,
      required this.availableTags,
      required this.agents,
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
          ? Expanded(
              child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    SharedPref().saveString(
                        "selectedInboxTags${_inboxController.tickets.dataSource!.elementAt(index).id.toString()}",
                        TagsDataSource.encode(_inboxController
                            .tickets.dataSource!
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
                                          _inboxController.tickets.dataSource!
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
                                                    .tickets.dataSource!
                                                    .elementAt(index)
                                                    .agents!
                                                    .length >
                                                0
                                            ? CircleAvatar(
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      _inboxController
                                                          .tickets.dataSource!
                                                          .elementAt(index)
                                                          .agents!
                                                          .elementAt(0)
                                                          .avatar!),
                                                  radius: 8,
                                                ),
                                                radius: 10,
                                                backgroundColor: Colors.white,
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
                                            _inboxController.tickets.dataSource!
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
                                            platformIcon(_inboxController
                                                .tickets.dataSource!
                                                .elementAt(index)
                                                .customer!
                                                .platform!
                                                .type!),
                                            size: 15,
                                            color: platformColor(
                                                _inboxController
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
                                        _inboxController.tickets.dataSource!
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
                                      readTimestamp(int.parse(_inboxController
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
                                          backgroundColor: _inboxController
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
                                          _inboxController.tickets.dataSource!
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
                                _inboxController.tickets.dataSource!
                                    .elementAt(index)
                                    .id,
                                _inboxController.tickets.dataSource!
                                    .elementAt(index)
                                    .customer,
                                widget.agents,
                                _inboxController.tickets.dataSource!
                                    .elementAt(index)
                                    .agents,
                                widget.cannedResponse,
                                _inboxController.tickets.dataSource!
                                    .elementAt(index)
                                    .tags
                              ]);
                            }));
                  },
                  itemCount: _inboxController.tickets.dataSource!.length),
            ))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            );
    });
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    widget.onRefresh();
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
