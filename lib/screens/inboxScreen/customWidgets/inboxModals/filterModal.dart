import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/projectsModels/data_source.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/assignedModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/channelModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/mainModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/tagsModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/timeModal.dart';
import 'package:myalice/utils/colors.dart';

class FilterModal extends StatefulWidget {
  List<ChannelDataSource?> selectedAnimals ;
  FilterModal({Key? key,required this.selectedAnimals}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<ChannelDataSource?> _selectedAnimals1 = [];
  List<String> _seletedAgents = [];
  List<String> _tags = [];
  @override
  Widget build(BuildContext context) {
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
                    Text(
                      "Filter Options",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Expanded(
                        child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Channels",
                              style: TextStyle(
                                fontWeight: widget.selectedAnimals.length <= 0
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              )),
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedAnimals1.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            AliceColors.ALICE_SELECTED_CHANNEL),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          _selectedAnimals1
                                              .elementAt(index)!
                                              .name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12)),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 0.5,
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 20, color: Colors.grey),
                          )
                        ],
                      ),
                    )),
                    onTap: () => showChannelModal(context, state),
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
                ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  title: Text("Assigned Agent/Group",
                      style: TextStyle(fontSize: 14)),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  minLeadingWidth: 0.0,
                  onTap: () {
                    showAssignedModal(context, state, _seletedAgents);
                  },
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
                    showTagsModal(context, state, _tags);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

/*   void showInboxModal(BuildContext context, InboxController controller) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isDismissible: true,
        builder: (context) {
          return MainModal(inboxController: controller);
        }).whenComplete(() => null);
  } */

  void showAssignedModal(
      BuildContext context, StateSetter state, List<String> selectedAgents) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return AssignedAgentModal(
            selectedAgents: selectedAgents,
          );
        });
  }

  void showTagsModal(
      BuildContext context, StateSetter state, List<String> tags) {
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

  void showChannelModal(BuildContext context, StateSetter state) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return ChannelModal(
            selectedAnimals: widget.selectedAnimals,
            onsaved: (List<ChannelDataSource?> valubbe) {
              _selectedAnimals1 = valubbe;
            },
          );
        }).whenComplete(() {
      state(() {
        widget.selectedAnimals = _selectedAnimals1;
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
