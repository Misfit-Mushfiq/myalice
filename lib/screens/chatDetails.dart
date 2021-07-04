import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/pusherController.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/utils/constant_strings.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late List<ChatMessage> messages = <ChatMessage>[];
  late final PusherService pusherService;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    pusherService = PusherService();
    await pusherService.connectPusher('chat-C_593', "messages");
  }

  @override
  Widget build(BuildContext context) {
    final obj = Get.put(ChatApiController());
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Obx(() {
                return Get.find<ChatApiController>().isDataAvailable
                    ? ListView.builder(
                        itemCount: obj.chats.dataSource!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (obj.chats.dataSource!
                                          .elementAt(index)
                                          .source ==
                                      "customer"
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (obj.chats.dataSource!
                                              .elementAt(index)
                                              .source ==
                                          "customer"
                                      ? CHAT_RECEIVER
                                      : CHAT_SENDER),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  obj.chats.dataSource!
                                              .elementAt(index)
                                              .source ==
                                          "customer"
                                      ? obj.chats.dataSource!
                                          .elementAt(index)
                                          .data!
                                          .text!
                                      : obj.chats.dataSource!
                                          .elementAt(index)
                                          .data!
                                          .data!
                                          .text!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: (obj.chats.dataSource!
                                                  .elementAt(index)
                                                  .source ==
                                              "customer"
                                          ? Colors.black
                                          : Colors.white)),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Text('Inbox is Empty');
              }),
            ),
            Container(
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
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      //await pusherService.pusherTrigger('test-event');
                    },
                    child: Icon(
                      Icons.send,
                      color: ALICE_GREEN,
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
