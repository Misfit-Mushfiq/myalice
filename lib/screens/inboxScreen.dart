import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myalice/custom%20widgets/BottomOptionWidget.dart';
import 'package:myalice/utils/colors.dart';
import 'package:smart_select/smart_select.dart';
import 'package:myalice/utils/choices.dart' as choices;

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  String _os = 'win';
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Live Chat',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 25,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://picsum.photos/250?image=9"),
                radius: 16.0,
              ),
            ),
          ],
          bottom: PreferredSize(
              child: Container(
                color: AliceColors.ALICE_GREEN,
                height: 40.0,
                child: Row(
                  children: [
                    Expanded(
                        child: SmartSelect<String>.single(
                      title: _os,
                      choiceItems: choices.ticketType,
                      modalHeader: false,
                      choiceType: S2ChoiceType.radios,
                      choiceStyle: S2ChoiceStyle(activeColor: Colors.green),
                      onChange: (selected) =>
                          setState(() => _os = selected.value),
                      modalType: S2ModalType.bottomSheet,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: true,
                          hideValue: true,
                          dense: true,
                          trailing: Text(''),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              _os,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          padding: EdgeInsets.only(bottom: 10.0, left: 8.0),
                        );
                      },
                      value: _os,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/launch_icon/filter.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/launch_icon/descending.svg",
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(40.0)),
        ),
        body: Container(
          child: SmartSelect<String>.single(
            title: 'OS',
            choiceItems: choices.os,
            onChange: (selected) => setState(() => _os = selected.value),
            modalType: S2ModalType.bottomSheet,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://source.unsplash.com/xsGxhtAsfSA/100x100',
                  ),
                ),
              );
            },
            value: _os,
          ),
        ));
  }
}
