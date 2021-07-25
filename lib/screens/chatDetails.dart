import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/pusherController.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/colors.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late List<ChatMessage> messages = <ChatMessage>[];
  late final PusherService pusherService;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    // _sharedPref.remove('apiToken');
    Get.find<ChatApiController>().closeDB();
    super.dispose();
  }

  Future<void> init() async {
    pusherService = PusherService();
    await pusherService.connectPusher('chat-C_593', "messages");
  }

  void animateToScreenEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final obj = Get.put(ChatApiController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Mark Tewin',
            style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
          ),
          centerTitle: false,
          titleSpacing: 35,
          leading: Row(children: [
          Icon(Icons.arrow_left,color: Colors.red,size: 25,),
          CircleAvatar(radius: 20,),
          ],),
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                        child: Text(
                          'Resolve',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                            color: AliceColors.ALICE_GREEN,
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.info_rounded,
                  )
                ],
              ),
            ),
          ],
          bottom: PreferredSize(
              child: ChatAppBarBottomSection(),
              preferredSize: Size.fromHeight(40.0)),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: Get.find<ChatApiController>().chats.length,
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 10, bottom: 00),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index + 1 ==
                            Get.find<ChatApiController>().chats.length) {
                          animateToScreenEnd();
                        }

                        //print(index);
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (obj.chats.elementAt(index)!.source ==
                                    "customer"
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (obj.chats.elementAt(index)!.source ==
                                        "customer"
                                    ? AliceColors.CHAT_RECEIVER
                                    : AliceColors.CHAT_SENDER),
                              ),
                              padding: EdgeInsets.all(16),
                              child: obj.chats.elementAt(index)!.type ==
                                          "attachment" &&
                                      obj.chats.elementAt(index)!.subType ==
                                          "image"
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          obj.chats.elementAt(index)!.imageUrl!,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Text(
                                      obj.chats.elementAt(index)!.source ==
                                              "customer"
                                          ? obj.chats.elementAt(index)!.text!
                                          : obj.chats.elementAt(index)!.text!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: (obj.chats
                                                      .elementAt(index)!
                                                      .source ==
                                                  "customer"
                                              ? Colors.black
                                              : Colors.white)),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            //await pusherService.pusherTrigger('test-event');
                            animateToScreenEnd();
                            Get.find<ChatApiController>()
                                .chatResponse
                                .add(DataSource.fromJson({
                                  "text": _textEditingController.text,
                                  "source": "admin",
                                  "sub_type": "",
                                  "type": ""
                                }));

                            Get.find<ChatApiController>()
                                .chatResponse
                                .refresh();
                          },
                          child: Icon(
                            Icons.send,
                            color: AliceColors.ALICE_GREEN,
                            size: 20,
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class ChatAppBarBottomSection extends StatefulWidget {
  @override
  _ChatAppBarBottomSectionState createState() =>
      _ChatAppBarBottomSectionState();
}

class _ChatAppBarBottomSectionState extends State<ChatAppBarBottomSection> {
  String _ticketType = 'Pending Tickets';
  bool _pendingSelected = true;
  bool _resolvedSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AliceColors.ALICE_GREY,
      height: 40.0,
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sell,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    "Agents",
                    style: TextStyle(color: Colors.black),
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
              Scaffold.of(context).showBottomSheet((BuildContext context) {
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
