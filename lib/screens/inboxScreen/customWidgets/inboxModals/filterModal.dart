import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/channelModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/mainModal.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/timeModal.dart';
import 'package:myalice/utils/colors.dart';

class FilterModal extends StatefulWidget {
  FilterModal({Key? key}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<Animal?> _selectedAnimals = [];
  List<Animal?> _selectedAnimals1 = [];
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
                                fontWeight: _selectedAnimals.length <= 0
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              )),
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedAnimals.length,
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
                                          _selectedAnimals
                                              .elementAt(index)!
                                              .name,
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
                    Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
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

  void showChannelModal(BuildContext context, StateSetter state) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return ChannelModal(
            selectedAnimals: _selectedAnimals,
            onsaved: (List<Animal?> value) {
              _selectedAnimals1 = value;
            },
          );
        }).whenComplete(() {
      state(() {
        _selectedAnimals = _selectedAnimals1;
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
