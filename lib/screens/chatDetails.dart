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
  bool _visiblity = false;
  bool _botEnabled = false;
  final _chatboxBottomSheet = GlobalKey<ScaffoldState>();
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
        key: _chatboxBottomSheet,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: AliceColors.ALICE_GREEN, size: 20),
                onPressed: () {
                  Get.back();
                },
              ),
              CircleAvatar(),
              SizedBox(
                width: 10,
              ),
              Text(
                'Mark Tewin',
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
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
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                            color: AliceColors.ALICE_GREEN,
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: AliceColors.ALICE_GREEN,
                    onPressed: () {
                      showModal(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.info_outline,
                    color: AliceColors.ALICE_GREEN,
                  )
                ],
              ),
            ),
          ],
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
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _visiblity = !_visiblity;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.add,
                                color: AliceColors.ALICE_GREEN,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Aa',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
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
                            _textEditingController.text = "";
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
                ),
                Visibility(
                    visible: _visiblity,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  "Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  "Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  "Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  "Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            )));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Used Tags"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    minLeadingWidth: 0.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text("Filter Tickets"),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/launch_icon/filter.svg",
                          color: Colors.black),
                    ),
                    minLeadingWidth: 0.0,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text("Bot"),
                    trailing: Switch(
                        activeColor: AliceColors.ALICE_GREEN,
                        value: _botEnabled,
                        onChanged: (bool onvalue) {
                          setState(() {
                            _botEnabled = onvalue;
                          });
                        }),
                    minLeadingWidth: 0.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
