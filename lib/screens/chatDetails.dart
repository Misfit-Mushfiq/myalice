import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(),
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
