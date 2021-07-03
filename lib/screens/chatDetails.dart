import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/constant_strings.dart';
import 'package:myalice/utils/shared_pref.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late List<ChatMessage> messages;
  final SharedPref _sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();
    init();
    messages = [
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(
          messageContent: "How have you been?", messageType: "receiver"),
      ChatMessage(
          messageContent: "Hey Kriss, I am doing fine dude. wbu?",
          messageType: "sender"),
      ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
      ChatMessage(
          messageContent: "Is there any thing wrong?", messageType: "sender"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final obj = Get.put(ChatApiController());
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            Obx(() {
              return obj.dataAvailable
                  ? Text(obj.chats.dataSource!.elementAt(25).data!.data!.text!)
                  : Text('... waiting ...');
            }),
            /* ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                          EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? CHAT_RECEIVER
                                : CHAT_SENDER),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent!,
                            style: TextStyle(
                                fontSize: 12,
                                color: (messages[index].messageType == "receiver"
                                    ? Colors.black
                                    : Colors.white)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                 */
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
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
                      onPressed: () {
                        messages.add(ChatMessage(
                            messageContent: "messageContent",
                            messageType: "messageType"));
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void init() {}
}
