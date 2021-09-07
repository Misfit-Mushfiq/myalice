import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableAgents/data_source.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/channels/channels.dart';
import 'package:myalice/models/responseModels/channels/data_source.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
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
  List<TagsDataSource?> _selectedTags = [];
  List<String> _selectedAgentsID = [];
  List<String> _selectedChannelsID = [];
  List<String> _selectedTagsID = [];
  List<String>? _selectedTimes = [];
  SharedPref _pref = SharedPref();
  @override
  void initState() {
    getSelectedAgents();
    super.initState();
  }

  getSelectedAgents() async {
    _selectedAgents = AssignedAgentsDataSource.decode(
        await _pref.readString("selectedAgents"));
    _selectedChannels =
        ChannelDataSource.decode(await _pref.readString("selectedChannels"));
    _selectedTags =
        TagsDataSource.decode(await _pref.readString("selectedTags"));
    _selectedTimes = await _pref.readStringList("selectedTimes") ?? [];
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
                        _selectedTags.length > 0 ||
                        _selectedTimes!.length > 0)
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
                                _selectedAgentsID.clear();

                                _selectedTags.clear();
                                _selectedTagsID.clear();

                                _selectedChannels.clear();
                                _selectedChannelsID.clear();

                                _selectedTimes!.clear();

                                _pref.remove("selectedAgents");
                                _pref.remove("selectedChannels");
                                _pref.remove("selectedTags");
                                _pref.remove("selectedTimes");

                                Get.find<InboxController>().getTickets(
                                    order: widget.sortNew ? "desc" : "",
                                    resolved: widget.resolvedSelected ? 1 : 0,
                                    search: "",
                                    channels: _selectedChannelsID,
                                    agents: _selectedAgentsID,
                                    groups: [],
                                    tags: _selectedTagsID,
                                    dates: _selectedTimes!);
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
                                Navigator.pop(context, true);

                                Get.find<InboxController>().getTickets(
                                    order: widget.sortNew ? "desc" : "",
                                    resolved: widget.resolvedSelected ? 1 : 0,
                                    search: "",
                                    channels: _selectedChannelsID,
                                    agents: _selectedAgentsID,
                                    groups: [],
                                    tags: _selectedTagsID,
                                    dates: _selectedTimes!);
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
                            padding: EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_SELECTED_CHANNEL),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        _selectedChannels
                                            .elementAt(index)!
                                            .title!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 10)),
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8.0,
                                    mainAxisExtent: 30.0,
                                    mainAxisSpacing: 8.0),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Time",
                            style: TextStyle(
                              fontWeight: _selectedTimes!.length <= 0
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            )),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _selectedTimes!.length,
                            padding: EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_SELECTED_CHANNEL),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        _selectedTimes!.elementAt(index),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 10)),
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisExtent: 30.0,
                                    mainAxisSpacing: 8.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.grey),
                        )
                      ],
                    ),
                    onTap: () => showTimePicker(context),
                  ),
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
                                    color: AliceColors.ALICE_SELECTED_CHANNEL),
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
                                            color: Colors.green, fontSize: 10)),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Tags",
                            style: TextStyle(
                              fontWeight: _selectedTags.length <= 0
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            )),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(8.0),
                            itemCount: _selectedTags.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_SELECTED_CHANNEL),
                                child: Center(
                                  child: Text(
                                      _selectedTags.elementAt(index)!.name!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 10)),
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    mainAxisExtent: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.grey),
                        )
                      ],
                    ),
                    onTap: () => showTagsModal(context, state, widget.tags),
                  ),
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
              for (int a = 0; a < value!.length; a++) {
                _selectedAgentsID.add(value.elementAt(a).admin!.id!.toString());
              }
              _pref.saveStringList("selectedAgentsID", _selectedAgentsID);
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
            onSaved: (List<TagsDataSource>? tags) {
              for (int a = 0; a < tags!.length; a++) {
                _selectedTagsID.add(tags.elementAt(a).id.toString());
              }
              _pref.saveStringList("selectedTagsID", _selectedTagsID);
            },
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
              for (int a = 0; a < value.length; a++) {
                _selectedChannelsID.add(value.elementAt(a)!.id.toString());
              }
              _pref.saveStringList("selectedChannelsID", _selectedChannelsID);
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
          return TimeModal(
            onSaved: (List<String> times) {
              _selectedTimes = times;
            },
          );
        });
  }
}
