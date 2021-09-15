import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class BotTurnOffConfirm extends StatefulWidget {
  final Function() onConfirm;
  BotTurnOffConfirm({Key? key, required this.onConfirm}) : super(key: key);

  @override
  _BotTurnOffConfirmState createState() => _BotTurnOffConfirmState();
}

class _BotTurnOffConfirmState extends State<BotTurnOffConfirm> {
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
              "Turn Off Bot",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "You are about to turn of all bot activities for this ticket. Please confirm your action.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  wordSpacing: 1,
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
                    'Confirm',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                //color: AliceColors.ALICE_GREEN,
                onPressed: () {
                  widget.onConfirm();
                  Get.back();
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
