import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/pusherController.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late List<ChatMessage> messages = <ChatMessage>[];
  late final PusherService pusherService;
  final SharedPref _sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _sharedPref.remove('apiToken');
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
                        itemCount: obj.chats.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
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
                                        imageUrl: obj.chats
                                            .elementAt(index)!
                                            .imageUrl!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Text(
                                        obj.chats.elementAt(index)!.source ==
                                                "customer"
                                            ? obj.chats.elementAt(0)!.text!
                                            : obj.chats.elementAt(0)!.text!,
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
                      Get.find<ChatApiController>().chatResponse.add(DataSource.fromJson({"Text":"hello","source":"customer","sub_type":"","type":""}));
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
          ],
        ));
  }
}
