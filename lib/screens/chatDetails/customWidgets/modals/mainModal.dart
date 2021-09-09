import 'package:flutter/material.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/assignedModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/tagsModal.dart';

class MainModal extends StatefulWidget {
  final items;
  MainModal({Key? key, required this.items}) : super(key: key);

  @override
  _MainModalState createState() => _MainModalState();
}

class _MainModalState extends State<MainModal> {
  bool _botEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
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
                          Text("Robert Becky"),
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
    );
  }

  void showAssignModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return InboxAssignedModal();
        });
  }

  void showTagsModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return InboxTagsModal(
            items: widget.items,
          );
        });
  }
}
