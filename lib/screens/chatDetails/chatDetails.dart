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
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/agent.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/customer.dart';
import 'package:myalice/screens/chatDetails/customWidgets/attachments/attachments.dart';
import 'package:myalice/screens/chatDetails/customWidgets/auto.dart';
import 'package:myalice/screens/chatDetails/customWidgets/chats/actionText.dart';
import 'package:myalice/screens/chatDetails/customWidgets/chats/texts.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/assignedModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/mainModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/tagsModal.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';

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
  bool _spaceVisiblity = false;
  bool _botEnabled = false;
  final _chatboxBottomSheet = GlobalKey<ScaffoldState>();
  late Tags _availableTags;
  late List<TagsDataSource> _usedTags;
  late AvailableAgents _agents;
  late AvailableGroups _groups;
  late CannedResponse _cannedResponse;
  late List<AssignedAgents> _assignedAgents;
  late int _ticketId;
  late Customer _customer;
  SharedPref _sharedPref = SharedPref();

  //List<Animal> _selectedChannels = [];
  List<Object?> _selectedChannels2 = [];
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

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
    _availableTags = args[0];
    _ticketId = args[1];
    _customer = args[2];
    _agents = args[3];
    _assignedAgents = args[4];
    _cannedResponse = args[5];
    _usedTags = args[6];
    _groups = args[7];
/*     _sharedPref.saveString(
                  "selectedInboxTags", TagsDataSource.encode(_usedTags)); */

    await pusherService.connectPusher(
        'chat-C_${_customer.id!.toString()}', "messages");
  }

  void animateToScreenEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  /*  void jumpToScreenEnd() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  } */

  @override
  Widget build(BuildContext context) {
    final obj = Get.put(ChatApiController());
    obj.updateCustomerID(int.parse(_customer.id!.toString()));
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
              Flexible(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(CUSTOMER_PROFILE_PAGE, arguments: [_customer]);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          _customer.fullName!,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 2,
                  ))
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.find<ChatApiController>().resolveTicket().then((value) {
                      if (value!) {
                        Get.offAllNamed(INBOX_PAGE);
                      }
                    });
                  },
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
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                ),
                SizedBox(width: 15),
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
                SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () {
                          if (Get.find<ChatApiController>()
                              .chatResponse
                              .value
                              .isNotEmpty) {
                            Timer(
                                Duration(milliseconds: 1),
                                () => _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(microseconds: 1),
                                      curve: Curves.easeIn,
                                    ));
                            return ListView.builder(
                              itemCount:
                                  Get.find<ChatApiController>().chats.length,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: true,
                              padding: EdgeInsets.only(top: 10, bottom: 00),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                // animateToScreenEnd();
                                /* if (index + 1 ==
                            Get.find<ChatApiController>().chats.length) {
                          animateToScreenEnd();
                        } */
                                //print(index);
                                return obj.chats.elementAt(index)!.type ==
                                            "action" ||
                                        obj.chats.elementAt(index)!.type ==
                                            "note"
                                    ? ActionText(
                                        text: obj.chats.elementAt(index)!.text!,
                                        type: obj.chats.elementAt(index)!.type,
                                      )
                                    : Texts(object: obj, index: index);
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  )),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    AutoCompleteExample(
                      onAttachmentTap: (bool visiblity) {
                        setState(() {
                          _visiblity = visiblity;
                          _spaceVisiblity = false;
                        });
                      },
                      onTextTap: (bool spaceVisiblity) {
                        setState(() {
                          _visiblity = false;
                          _spaceVisiblity = spaceVisiblity;
                        });
                      },
                      cannedResponse: _cannedResponse,
                      ticketID: _ticketId.toString(),
                    ),
                    Visibility(
                        visible: _spaceVisiblity,
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                            )
                          ],
                        )

                        /* Container(
                          padding:
                              EdgeInsets.only(bottom: 10, top: 10, right: 10),
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
                                      _textEditingController.text,
                                      "");
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
                       */
                        )
                  ],
                )),
            Visibility(
                visible: _visiblity,
                child: Attachments(
                    ticketId: _ticketId.toString(),
                    cannedResponse: _cannedResponse))
          ],
        ));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MainModal(
            onsaVed: (items) {
              _sharedPref.saveString("selectedInboxTags${_ticketId.toString()}",
                  TagsDataSource.encode(items));
            },
            ticketID: _ticketId,
            agents: _agents,
            groups: _groups,
            customerID: _customer.id.toString(),
            assignAgents: _assignedAgents,
            availableTags: _availableTags.dataSource,
            usedTags: _usedTags,
          );
        });
  }
}
