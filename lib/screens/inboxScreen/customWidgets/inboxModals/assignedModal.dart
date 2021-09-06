import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/models/availableAgents/assigned_agents.dart';
import 'package:myalice/models/availableAgents/data_source.dart';
import 'package:myalice/models/availableGroups/available_groups.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignedAgentModal extends StatefulWidget {
  AvailableGroups groups;
  AssignedAgents agents;
  final Function(List<AssignedAgentsDataSource>?) onsaved;
  AssignedAgentModal(
      {Key? key,
      required this.groups,
      required this.agents,
      required this.onsaved})
      : super(key: key);

  @override
  _AssignedAgentModalState createState() => _AssignedAgentModalState();
}

class _AssignedAgentModalState extends State<AssignedAgentModal> {
  String searchTitle = "Search for agents/groups";
  bool assignedAgents = true;
  List<AssignedAgentsDataSource> _selectedAgents = [];
  List<String> _selectedAgentsID = [];
  List<AssignedAgentsDataSource>? _availableAgents = [];
  final SharedPref _sharedPref = SharedPref();
  @override
  void initState() {
    _availableAgents = widget.agents.dataSource;
    /* for (int a = 0; a < widget.agents.dataSource!.length; a++) {
      _availableAgents!
          .add(widget.agents.dataSource!.elementAt(a).admin!.fullName!);
    } */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.agents.dataSource!.map((e) => e.admin!.fullName!);
    return Wrap(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(child: Text("Assigned Agent/Group")),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
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
                      onTap: () {}),
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
                                      fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        widget.onsaved(_selectedAgents);
                        _sharedPref.saveString("selectedAgents", AssignedAgentsDataSource.encode(_selectedAgents));
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<AssignedAgentsDataSource>(
                    mode: Mode.BOTTOM_SHEET,
                    items: _availableAgents,
                    hint: "Search for agents/groups",
                    onChanged: (value) {
                      setState(() {
                        _selectedAgents.add(value!);
                        _selectedAgentsID.add(value.admin!.id.toString());
                        assignedAgents = false;
                      });
                    },
                    popupItemBuilder: (context,
                        AssignedAgentsDataSource? agents, bool selected) {
                      return Container(
                        child: ListTile(
                          title: Text(agents!.admin!.fullName!),
                          trailing: selected ? Icon(Icons.check) : null,
                        ),
                      );
                    },
                    searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            hintText: "Search for agents/groups",
                            contentPadding: EdgeInsets.only(left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ))),
                    dropdownSearchTextAlign: TextAlign.start,
                    showSelectedItem: false,
                    emptyBuilder: (context, String? text) {
                      return Scaffold(
                        body: Container(
                          child: Center(child: Text("No data found")),
                        ),
                      );
                    },
                    dropdownBuilder: (BuildContext context,
                        AssignedAgentsDataSource? agents,
                        String itemDesignation) {
                      return Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Search for agents/groups",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      );
                    },
                    dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    showSearchBox: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: assignedAgents
                                ? AliceColors.ALICE_SELECTED_CHANNEL
                                : AliceColors.ALICE_GREY),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("All Assigned Agents",
                              style: TextStyle(
                                  color: assignedAgents
                                      ? Colors.green
                                      : Colors.black)),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          assignedAgents = true;
                          _selectedAgents.clear();
                        });
                      },
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _selectedAgents.length <= 0
                                ? assignedAgents
                                    ? AliceColors.ALICE_GREY
                                    : AliceColors.ALICE_SELECTED_CHANNEL
                                : AliceColors.ALICE_GREY),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Assigned To None",
                            style: TextStyle(
                                color: _selectedAgents.length <= 0
                                    ? assignedAgents
                                        ? Colors.black
                                        : Colors.green
                                    : Colors.black),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          assignedAgents = false;
                          _selectedAgents.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _selectedAgents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AliceColors.ALICE_SELECTED_CHANNEL),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          _selectedAgents
                                              .elementAt(index)
                                              .admin!
                                              .fullName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.close,
                                          size: 10, color: Colors.green)
                                    ]),
                                onTap: () {
                                  setState(() {
                                    _selectedAgents.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.5,
                        mainAxisExtent: 25.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 3),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
