import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableAgents/data_source.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/availableGroups/data_source.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/reassignConfirm.dart';
import 'package:myalice/utils/colors.dart';

class InboxAssignedModal extends StatefulWidget {
  final AvailableAgents agents;
  final AvailableGroups groups;
  final ticketID;
  final Function(String agentName) onSaved;
  InboxAssignedModal(
      {Key? key,
      required this.agents,
      required this.groups,
      required this.ticketID,
      required this.onSaved})
      : super(key: key);

  @override
  _AssignedModalState createState() => _AssignedModalState();
}

class _AssignedModalState extends State<InboxAssignedModal> {
  List<AvailableAgentsDataSource> _agents = [];
  List<AvailableGroupsDataSource> _groups = [];
  String selectedAgentName = '';
  String selectedAgentpic = "";
  @override
  void initState() {
    getAgents();
    super.initState();
  }

  getAgents() {
    _agents = widget.agents.dataSource!;
    _groups=  widget.groups.dataSource!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 500,
          decoration: BoxDecoration(
            // color: colorPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: const Radius.circular(18.0),
            ),
          ),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leadingWidth: 20,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
                bottom: TabBar(
                  labelColor: AliceColors.ALICE_GREEN,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AliceColors.ALICE_GREEN,
                  tabs: [
                    Tab(
                      text: "Agents",
                    ),
                    Tab(
                      text: "Groups",
                    ),
                  ],
                ),
                title: Text(
                  'Ressaign Ticket',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                centerTitle: false,
              ),
              body: TabBarView(
                children: [
                  ListView.separated(
                    itemCount: _agents.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showModal(
                              context,
                              _agents
                                  .elementAt(index)
                                  .admin!
                                  .id
                                  .toString()
                                  .toString(),
                              _agents.elementAt(index).admin!.fullName!,
                              "",
                              "");
                        },
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _agents.elementAt(index).admin!.avatar!),
                              radius: 25,
                            ),
                            Positioned(
                                top: 40,
                                left: 35,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(selectedAgentpic),
                                  backgroundColor:
                                      _agents.elementAt(index).admin!.status! ==
                                              "online"
                                          ? AliceColors.ALICE_GREEN
                                          : AliceColors.ALICE_ORANGE,
                                  radius: 5,
                                ))
                          ],
                        ),
                        title: Text(
                          _agents.elementAt(index).admin!.fullName!,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        subtitle: Text(
                          _agents.elementAt(index).admin!.status!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
                  ListView.separated(
                    itemCount: _groups.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(_groups.elementAt(index).image!),
                            radius: 25,
                          ),
                          title: Text(
                            _groups.elementAt(index).name!,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          onTap: (){
                            showModal(
                              context,
                              "",
                              "",
                              _groups.elementAt(index).name!,
                              _groups.elementAt(index).id.toString());
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  showModal(BuildContext context, String agentID, String agentName,
      String groupName, String groupID) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        useRootNavigator: true,
        builder: (context) {
          return ReassignConfirm(
            agentID: agentID,
            groupID: groupID,
            ticketID: widget.ticketID,
            agentName: agentName,
            groupName: groupName,
            onSaved: (String name) {
              widget.onSaved(name);
            },
          );
        }).whenComplete(() {});
  }
}
