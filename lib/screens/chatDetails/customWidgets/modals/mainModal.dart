import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/agent.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/assignedModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/tagsModal.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class MainModal extends StatefulWidget {
  final usedTags;
  final availableTags;
  final agents;
  final ticketID;
  final List<AssignedAgents> assignAgents;
  final Function(List<TagsDataSource> tags) onsaVed;
  MainModal(
      {Key? key,
      required this.availableTags,
      required this.agents,
      required this.assignAgents,
      required this.usedTags,
      required this.onsaVed,
      required this.ticketID})
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
    _usedTags = widget.usedTags;
    _selectedTags = TagsDataSource.decode(
        await _sharedPref.readString("selectedInboxTags${widget.ticketID}"));

    setState(() {});
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text("Used Tags"),
                      ),
                      Flexible(
                          flex: 1,
                          child: MultiSelectChipDisplay<TagsDataSource>(
                            scroll: true,
                            scrollBar: HorizontalScrollBar(isAlwaysShown: true),
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            chipColor: AliceColors.ALICE_SELECTED_CHANNEL,
                            textStyle: TextStyle(color: Colors.green),
                            onTap: (item) {
                              _selectedTags.remove(item);
                              widget.onsaVed(_selectedTags);
                              Get.find<ChatApiController>().removeTicketTags(
                                  action: 'remove',
                                  name: item.name!,
                                  tagId: item.id!);
                              setState(() {});
                            },
                            items: _selectedTags
                                .map((e) => MultiSelectItem(e, e.name!))
                                .toList(),
                          ))
                      /* Flexible(
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
                       */
                      ,
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
                            Text(widget.assignAgents.length > 0
                                ? widget.assignAgents.elementAt(0).fullName!
                                : ""),
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
      setState(() {});
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
              _selectedTags.addAllIf(selectedTags.any((item) => !_selectedTags.contains(item)), selectedTags);
              _sharedPref.saveString(
                  "selectedInboxTags${widget.ticketID.toString()}",
                  TagsDataSource.encode(_selectedTags));
            },
          );
        }).whenComplete(() {
      for (int i = 0; i < _selectedTags.length; i++) {
        Get.find<ChatApiController>().addTicketTags("add",
            _selectedTags.elementAt(i).name!, _selectedTags.elementAt(i).id!);
      }
      setState(() {});
    });
  }
}
