import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/utils/colors.dart';

class AssignedAgentModal extends StatefulWidget {
  List<String> selectedAgents = [];
  AssignedAgentModal({Key? key, required this.selectedAgents})
      : super(key: key);

  @override
  _AssignedAgentModalState createState() => _AssignedAgentModalState();
}

class _AssignedAgentModalState extends State<AssignedAgentModal> {
  String searchTitle = "Search for agents/groups";
  bool assignedAgents = true;
  @override
  Widget build(BuildContext context) {
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
                      onTap: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>(
                    mode: Mode.BOTTOM_SHEET,
                    items: ["Brazil", "Tunisia", 'Canada'],
                    hint: "Search for agents/groups",
                    onChanged: (value) {
                      setState(() {
                        widget.selectedAgents.add(value!);
                        assignedAgents = false;
                      });
                    },
                    popupItemBuilder: (context, String? tag, bool selected) {
                      return Container(
                        child: ListTile(
                          title: Text(tag!),
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
                    showSelectedItem: true,
                    emptyBuilder: (context, String? text) {
                      return Scaffold(
                        body: Container(
                          child: Center(child: Text("No data found")),
                        ),
                      );
                    },
                    dropdownBuilder: (BuildContext context, String? item,
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
                          widget.selectedAgents.clear();
                        });
                      },
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widget.selectedAgents.length <= 0
                                ? assignedAgents
                                    ? AliceColors.ALICE_GREY
                                    : AliceColors.ALICE_SELECTED_CHANNEL
                                : AliceColors.ALICE_GREY),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Assigned To None",
                            style: TextStyle(
                                color: widget.selectedAgents.length <= 0
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
                          widget.selectedAgents.clear();
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
                    itemCount: widget.selectedAgents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AliceColors.ALICE_SELECTED_CHANNEL),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        widget.selectedAgents
                                            .elementAt(index)
                                            .tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 12)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.close,
                                        size: 10, color: Colors.green)
                                  ]),
                              onTap: () {
                                setState(() {
                                  widget.selectedAgents.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
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
