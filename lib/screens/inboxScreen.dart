import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/choices.dart' as choices;
import 'package:myalice/utils/routes.dart';


class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: InboxAppBarBottomSection(),
              preferredSize: Size.fromHeight(40.0)),
        ),
        body: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.toNamed(CHAT_DETAILS_PAGE);
                          },
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          horizontalTitleGap: 10,
                          selected: true,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://picsum.photos/250?image=9"),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
                          title: Text(
                            "Mr. Baal",
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_GREY,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.facebook,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Online Store",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer()
                              ])),
                          trailing: Column(
                            children: [
                              Text(
                                '5 mins ago',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 10.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_GREY,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 3.0, 0.0, 3.0),
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: NetworkImage(
                                              "https://picsum.photos/250?image=9"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 3.0, 8.0, 3.0),
                                        child: Text(
                                          "Chef's Food",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_GREY,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AliceColors.ALICE_GREEN,
                                          radius: 5,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Low",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AliceColors.ALICE_GREY,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.lock,
                                      size: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 10)));
  }
}

class InboxAppBarBottomSection extends StatefulWidget {
  @override
  _InboxAppBarBottomSectionState createState() => _InboxAppBarBottomSectionState();
}

class _InboxAppBarBottomSectionState extends State<InboxAppBarBottomSection> {
  String _ticketType = 'Pending Tickets';
  bool _pendingSelected = true;
  bool _resolvedSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AliceColors.ALICE_GREEN,
      height: 40.0,
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    _ticketType,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onTap: () {
              Scaffold.of(context)
                  .showBottomSheet((BuildContext context) {
                return Container(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('Pending Tickets'),
                          trailing: _pendingSelected ? Icon(Icons.check) : null,
                          onTap: () {
                            setState(() {
                              _ticketType = "Pending Tickets";
                              _pendingSelected = true;
                              _resolvedSelected = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('Resolved Tickets'),
                          trailing:
                              _resolvedSelected ? Icon(Icons.check) : null,
                          onTap: () {
                            setState(() {
                              _ticketType = "Resolved Tickets";
                              _pendingSelected = false;
                              _resolvedSelected = true;
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                );
              });
            },
          )

              /* SmartSelect<String>.single(
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
                          selected: true,
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
                    ) */
              ),
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
    );
  }
}
