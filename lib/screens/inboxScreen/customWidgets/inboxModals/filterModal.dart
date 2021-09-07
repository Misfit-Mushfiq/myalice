import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/availableAgents/assigned_agents.dart';
import 'package:myalice/models/availableAgents/data_source.dart';
import 'package:myalice/models/availableGroups/available_groups.dart';
import 'package:myalice/models/channels/channels.dart';
import 'package:myalice/models/channels/data_source.dart';
import 'package:myalice/models/projectsModels/data_source.dart';
import 'package:myalice/models/projectsModels/projects.dart';
import 'package:myalice/models/tags/tags.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/assignedModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/channelModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/mainModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/tagsModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/timeModal.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class FilterModal extends StatefulWidget {
  Channels channels;
  AvailableGroups groups;
  AssignedAgents agents;
  Tags tags;
  bool sortNew;
  bool resolvedSelected;
  FilterModal(
      {Key? key,
      required this.channels,
      required this.agents,
      required this.groups,
      required this.tags,
      required this.sortNew,
      required this.resolvedSelected})
      : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<ChannelDataSource?> _selectedChannels = [];
  List<AssignedAgentsDataSource?> _selectedAgents = [];
  List<String?> _selectedAgentsID = [];
  List<String?> _selectedTags = [];
  SharedPref _pref = SharedPref();
  @override
  void initState() {
    getSelectedAgents();
    super.initState();
  }

  getSelectedAgents() async {
    _selectedAgents = AssignedAgentsDataSource.decode(
        await _pref.readString("selectedAgents"));
    _selectedChannels = ChannelDataSource.decode(
        await _pref.readString("selectedChannels"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getSelectedAgents();
    return StatefulBuilder(builder: (context, StateSetter state) {
      return Wrap(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          Get.back();
                          //showInboxModal(context, Get.find<InboxController>());
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Text(
                        "Filter Options",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    if (_selectedChannels.length > 0 ||
                        _selectedAgents.length > 0 ||
                        _selectedTags.length > 0)
                      Row(
                        children: [
                          InkWell(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 8.0, 8.0),
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
                                Get.back();
                                _selectedAgents.clear();
                                _pref.remove("selectedAgents");
                                _selectedChannels.clear();
                                _pref.remove("selectedChannels");
                                _selectedAgentsID.clear();
                              }),
                          InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AliceColors.ALICE_GREEN),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Filter",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.back();
                                Get.find<InboxController>().getTickets(
                                    widget.sortNew ? "desc" : "",
                                    widget.resolvedSelected ? 1 : 0,
                                    "",
                                    [],
                                    _selectedAgentsID,
                                    [],
                                    _selectedTags);
                              }),
                        ],
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Channels",
                              style: TextStyle(
                                fontWeight: _selectedChannels.length <= 0
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              )),
                           Flexible(
                             flex: 1,
                             fit: FlexFit.tight,
                             child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: _selectedChannels.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(left: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            AliceColors.ALICE_SELECTED_CHANNEL),
                                    child:  Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Center(
                                          child: Text(
                                              _selectedChannels
                                                  .elementAt(index)!
                                                  .title!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 10)),
                                        ),
                                      ),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 0.5,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 2.5),
                              ),
                           ),                       
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.grey),
                          )
                        ],
                      ),
                    
                    onTap: () =>
                        showChannelModal(context, state, widget.channels),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text("Time", style: TextStyle(fontSize: 14)),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    showTimePicker(context);
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Assigned Agents/Groups",
                              style: TextStyle(
                                fontWeight: _selectedAgents.length <= 0
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              )),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedAgents.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          AliceColors.ALICE_SELECTED_CHANNEL),
                                  child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text(
                                            _selectedAgents
                                                .elementAt(index)!
                                                .admin!
                                                .fullName!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 10)),
                                      ),
                                    ),
                                 
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0.5,
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 2.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.grey),
                          )
                        ],
                      ),
                   
                    onTap: () => showAssignedModal(
                        context, state, widget.agents, widget.groups),
                  ),
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
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    showTagsModal(context, state, widget.tags);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void showAssignedModal(BuildContext context, StateSetter state,
      AssignedAgents agents, AvailableGroups availableGroups) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return AssignedAgentModal(
            agents: agents,
            groups: availableGroups,
            onsaved: (List<AssignedAgentsDataSource>? value) {
              //_selectedAgents = value!;
              for (int a = 0; a < value!.length; a++) {
                _selectedAgentsID.add(value.elementAt(a).admin!.id!.toString());
              }
            },
          );
        }).whenComplete(() {
      state(() {});
    });
  }

  void showTagsModal(BuildContext context, StateSetter state, Tags tags) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return TagsModal(
            tags: tags,
          );
        });
  }

  void showChannelModal(
      BuildContext context, StateSetter state, Channels channels) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return ChannelModal(
            //    selectedChannels: widget.selectedChannels,
            channels: channels,
            onsaved: (List<ChannelDataSource?> value) {
              //_selectedChannels = value;
            },
          );
        }).whenComplete(() {
      state(() {
        setState(() {});
      });
    });
  }

  void showTimePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return TimeModal();
        });
  }
}
