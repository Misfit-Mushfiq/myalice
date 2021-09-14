import 'package:flutter/material.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/agent.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/assignedModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/tagsModal.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class MainModal extends StatefulWidget {
  final usedTags;
  final availableTags;
  final agents;
  final List<AssignedAgents> assignAgents;
  MainModal(
      {Key? key,
      required this.availableTags,
      required this.agents,
      required this.assignAgents,
      required this.usedTags})
      : super(key: key);

  @override
  _MainModalState createState() => _MainModalState();
}

class _MainModalState extends State<MainModal> {
  bool _botEnabled = false;
  late List<TagsDataSource> _selectedTags;
  List<TagsDataSource> _usedTags = [];
  SharedPref _sharedPref = SharedPref();
  String _selectedAgent = '';

  @override
  void initState() {
    getTags();
    super.initState();
  }

  getTags() async {
    setState(() {
       _usedTags = widget.usedTags;
    _selectedTags = _usedTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Used Tags"),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: _selectedTags.length,
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
                                      _selectedTags.elementAt(index).name!,
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
                      Icon(Icons.arrow_forward_ios, color: Colors.grey)
                    ],
                  ),
                  onTap: () {
                    showTagsModal(context);
                  },
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Assigned Agent"),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.assignAgents.length>0? widget.assignAgents.elementAt(0).fullName!:""),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.grey)
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      showAssignModal(context);
                    }),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Bot"),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          BottomSheetSwitch(
                            switchValue: _botEnabled,
                            valueChanged: (value) {
                              _botEnabled = value;
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  void showAssignModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return InboxAssignedModal(
            agents: widget.agents,
            onSaved: (String selectedAgent) {
              _selectedAgent = selectedAgent;
            },
          );
        }).whenComplete(() {
          setState(() {
            
          });
        });
  }

  void showTagsModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return InboxTagsModal(
            tags: widget.availableTags,
            selectedTags: _selectedTags,
            onsaved: (List<TagsDataSource> selectedTags) {
              _selectedTags = selectedTags;
            },
          );
        }).whenComplete(() {
      setState(() {});
    });
  }
}
