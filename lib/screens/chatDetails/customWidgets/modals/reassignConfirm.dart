import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class ReassignConfirm extends StatefulWidget {
  final String agentID;
  final String agentName;
  final String groupID;
  final String groupName;
  final Function(String name) onSaved;
  ReassignConfirm(
      {Key? key,
      required this.agentID,
      required this.groupID,
      required this.onSaved,
      required this.agentName,
      required this.groupName})
      : super(key: key);

  @override
  _ReassignConfirmState createState() => _ReassignConfirmState();
}

class _ReassignConfirmState extends State<ReassignConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundColor: AliceColors.ALICE_ORANGE_LIGHT,
            child: ClipRRect(
              child: SvgPicture.asset("assets/launch_icon/exclamation.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Confirm Reassignment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "You are about to reassign Ticket #28456\nPlease confirm your action.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  wordSpacing: 1.5,
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: ElevatedButton(
                /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ), */
                style: ElevatedButton.styleFrom(
                    primary: AliceColors.ALICE_ORANGE,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ))),
                child: Padding(
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Text(
                    'Reassign',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                //color: AliceColors.ALICE_GREEN,
                onPressed: () {
                  Get.find<ChatApiController>()
                      .reassign(widget.agentID, widget.groupID)
                      .then((value) {
                    if (value!) {
                      widget.onSaved(widget.agentName);
                      Get.offAllNamed(INBOX_PAGE);
                    } else {
                      Get.snackbar("", "Something went wrong");
                    }
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
                child: Padding(
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                //color: AliceColors.ALICE_GREEN,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
