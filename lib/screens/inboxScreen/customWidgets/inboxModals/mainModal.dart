import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/channels/channels.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/filterModal.dart';
import 'package:myalice/utils/shared_pref.dart';

class MainModal extends StatefulWidget {
  Channels channels;
  AvailableGroups groups;
  AssignedAgents agents;
  Tags tags;
  InboxController inboxController;
  bool pendingSelected;
  bool resolvedSelected;
  bool sortNew;
  final Function(bool pendingSelected, bool resolvedSelected, bool sortNew)
      onChanged;
  MainModal(
      {Key? key,
      required this.inboxController,
      required this.pendingSelected,
      required this.resolvedSelected,
      required this.sortNew,
      required this.onChanged,
      required this.channels,
      required this.agents,
      required this.groups,
      required this.tags})
      : super(key: key);

  @override
  _MainModalState createState() => _MainModalState();
}

class _MainModalState extends State<MainModal> {
  SharedPref _sharedPref = SharedPref();
  List<String>? _selectedAgentsID = [];
  List<String>? _selectedChannelsID = [];
  List<String>? _selectedTagsID = [];
  List<String>? _selectedTimes = [];
  @override
  void initState() {
    getFilterdData();
    super.initState();
  }

  getFilterdData() async {
    _selectedChannelsID =
        await _sharedPref.readStringList("selectedChannelsID") ?? [];
    _selectedAgentsID =
        (await _sharedPref.readStringList("selectedAgentsID")) ?? [];
    _selectedTagsID =
        (await _sharedPref.readStringList("selectedTagsID")) ?? [];
    _selectedTimes = await _sharedPref.readStringList("selectedTimes") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.pendingSelected
                    ? " Resolved Tickets"
                    : " Pending Tickets",
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                widget.pendingSelected
                    ? Icons.check_circle_outline
                    : Icons.lock_clock,
                color: Colors.black,
                size: 25,
              ),
              minLeadingWidth: 0.0,
              contentPadding: EdgeInsets.only(left: 10.0),
              onTap: () {
                setState(() async {
                  widget.pendingSelected = !widget.pendingSelected;
                  widget.resolvedSelected = !widget.resolvedSelected;
                  widget.inboxController.isticketsDataAvailable.value = false;
                  widget.resolvedSelected
                      ? widget.inboxController.resolved = 1
                      : widget.inboxController.resolved = 0;
                  widget.inboxController.getTickets(
                      order: widget.inboxController.sort,
                      resolved: widget.inboxController.resolved,
                      search: "",
                      channels: _selectedChannelsID!,
                      agents: _selectedAgentsID!,
                      groups: [],
                      tags: _selectedTagsID!,
                      dates: _selectedTimes!);
                });
                widget.onChanged(widget.pendingSelected,
                    widget.resolvedSelected, widget.sortNew);
                Get.back();
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
                showFilterModal(context, widget.channels, widget.agents,
                    widget.groups, widget.tags);
              },
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
                contentPadding: EdgeInsets.only(left: 10.0),
                title: widget.sortNew
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
                onTap: () async {
                  setState(() {
                    widget.sortNew = !widget.sortNew;
                    widget.inboxController.isticketsDataAvailable.value = false;
                    widget.sortNew
                        ? widget.inboxController.sort = "asc"
                        : widget.inboxController.sort = "desc";
                    widget.inboxController.getTickets(
                        order: widget.inboxController.sort,
                        resolved: widget.inboxController.resolved,
                        search: "",
                        channels: _selectedChannelsID!,
                        agents: _selectedAgentsID!,
                        groups: [],
                        tags: _selectedTagsID!,
                        dates: _selectedTimes!);
                  });
                  widget.onChanged(widget.pendingSelected,
                      widget.resolvedSelected, widget.sortNew);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }

  void showFilterModal(BuildContext context, Channels channels,
      AssignedAgents agents, AvailableGroups groups, Tags tags) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return FilterModal(
            channels: channels,
            groups: groups,
            agents: agents,
            tags: tags,
            sortNew: widget.sortNew,
            resolvedSelected: widget.resolvedSelected,
          );
        }).whenComplete(() {
      Get.back();
    });
  }
}
