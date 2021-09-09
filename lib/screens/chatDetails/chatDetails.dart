import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/pusherController/pusherController.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/screens/chatDetails/customWidgets/attachments/attachments.dart';
import 'package:myalice/screens/chatDetails/customWidgets/chats/actionText.dart';
import 'package:myalice/screens/chatDetails/customWidgets/chats/texts.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/assignedModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/mainModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/tagsModal.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails>
    with SingleTickerProviderStateMixin {
  late List<ChatMessage> messages = <ChatMessage>[];
  late final PusherService pusherService;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  bool _visiblity = false;
  bool _botEnabled = false;
  final _chatboxBottomSheet = GlobalKey<ScaffoldState>();
  late Tags _tags;
  late var _items;
  late int _ticketId;
  late String _name;
  late String _customerId;

  //List<Animal> _selectedChannels = [];
  List<Object?> _selectedChannels2 = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    Get.find<ChatApiController>().closeDB();
    super.dispose();
  }

  Future<void> init() async {
    pusherService = PusherService();
    var args = Get.arguments;
    _tags = args[0];
    _ticketId = args[1];
    _name = args[2];
    _customerId = args[3];
    _items = _tags.dataSource!
        .map((channel) =>
            MultiSelectItem<TagsDataSource>(channel, channel.name!))
        .toList()
        .obs;
    await pusherService.connectPusher('chat-C_$_customerId', "messages");
  }

  void animateToScreenEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void jumpToScreenEnd() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final obj = Get.put(ChatApiController());
    obj.updateID(_ticketId);
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
                width: 5,
              ),
              Flexible(
                child: Text(
                  _name,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            Row(
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
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
                ),
                SizedBox(width: 5),
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.settings,
                    size: 20,
                  ),
                  color: AliceColors.ALICE_GREEN,
                  onPressed: () {
                    showModal(context);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.info_outline,
                    size: 20,
                  ),
                  color: AliceColors.ALICE_GREEN,
                  onPressed: () {
                    Get.toNamed(CUSTOMER_PROFILE_PAGE);
                  },
                ),
                SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
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
                        //jumpToScreenEnd();
                        if (index + 1 ==
                            Get.find<ChatApiController>().chats.length) {
                          animateToScreenEnd();
                        }
                        //print(index);
                        return obj.chats.elementAt(index)!.type == "action"
                            ? ActionText(
                                text: obj.chats.elementAt(index)!.text!)
                            : Texts(object: obj, index: index);
                      },
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10, right: 10),
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _visiblity = !_visiblity;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: AliceColors.ALICE_GREEN,
                              size: 20,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
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
                        IconButton(
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
                            Get.find<ChatApiController>().sendChats(
                                _ticketId.toString(),
                                _textEditingController.text);
                            _textEditingController.text = "";
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.send,
                            color: AliceColors.ALICE_GREEN,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(visible: _visiblity, child: Attachments())
              ],
            )));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return MainModal(
            items: _items,
          );
        });
  }
}
