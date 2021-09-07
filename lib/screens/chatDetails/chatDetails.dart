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
  List<TagsDataSource>? _tagsLlist = [];

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
    _tags = Get.arguments;
    _tagsLlist = _tags.dataSource;
    pusherService = PusherService();
    _items = _tags.dataSource!
        .map((channel) =>
            MultiSelectItem<TagsDataSource>(channel, channel.name!))
        .toList()
        .obs;
    await pusherService.connectPusher('chat-C_650', "messages");
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
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                ),
                SizedBox(width: 8),
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.settings),
                  color: AliceColors.ALICE_GREEN,
                  onPressed: () {
                    showModal(context);
                  },
                ),
                IconButton(
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.toNamed(CUSTOMER_PROFILE_PAGE);
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: AliceColors.ALICE_GREEN,
                    ))
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
                        if (index + 1 ==
                            Get.find<ChatApiController>().chats.length) {
                          animateToScreenEnd();
                        }

                        //print(index);
                        return Container(
                          padding:
                              EdgeInsets.only(left: 14, right: 14, top: 10),
                          child: Align(
                            alignment: (obj.chats.elementAt(index)!.source ==
                                    "customer"
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    obj.chats.elementAt(index)!.source ==
                                            "customer"
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                color: (obj.chats.elementAt(index)!.source ==
                                        "customer"
                                    ? AliceColors.CHAT_RECEIVER
                                    : AliceColors.CHAT_SENDER),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                                          fontSize: 14,
                                          height: 1.8,
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
                            _textEditingController.text = "";
                            Get.find<ChatApiController>()
                                .chatResponse
                                .refresh();
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
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.attachment,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 5.0, 8.0, 5.0),
                                    child: Center(
                                        child: Text(
                                      "Attach",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.image,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 5.0, 8.0, 5.0),
                                    child: Center(
                                        child: Text(
                                      "Image",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.message,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0.0, 8.0, 2.0),
                                    child: Center(
                                        child: Text(
                                      "Canned\nResponse",
                                      textAlign: TextAlign.center,
                                      maxLines: null,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.note,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 5.0, 8.0, 5.0),
                                    child: Center(
                                        child: Text(
                                      "Note",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  )
                                ],
                              ),
                            ),
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
            color: Colors.white,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Used Tags"),
                          Icon(Icons.arrow_forward_ios, color: Colors.grey)
                        ],
                      ),
                      onTap: () {
                        showTagsModal(context);
                      },
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Assigned Agent"),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Robert Becky"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey)
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          showAssignModal(context);
                        }),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bot"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _botEnabled,
                                valueChanged: (value) {
                                  _botEnabled = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showTagsModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text("Used Tags"),
                      ),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add New Tags",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                             // _animals.add(Animal(id: 4, name: "Lionss"));
                            });
                          })
                    ],
                  ),
                  Wrap(
                    children: [
                      Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: MultiSelectChipField(
                              items: _items,
                              showHeader: false,
                              scroll: false,
                              initialValue: _selectedChannels2,
                              headerColor: Colors.white,
                              chipShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              decoration: BoxDecoration(),
                              selectedChipColor: AliceColors.ALICE_GREEN,
                              selectedTextStyle: TextStyle(color: Colors.white),
                              onTap: (values) {
                                _selectedChannels2 = values;
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /* _selectedChannels2.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "None selected",
                                        style: TextStyle(color: Colors.black54),
                                      ))
                                  : MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedChannels2.remove(value);
                                    });
                                  },
                                ), */
                        ],
                      ),
                    )
                    ] ,
                  )
                ],
              ));
        });
  }

  void showAssignModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.zero,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 500,
                decoration: BoxDecoration(
                  // color: colorPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: const Radius.circular(18.0),
                  ),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      leadingWidth: 20,
                      leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                      bottom: TabBar(
                        labelColor: AliceColors.ALICE_GREEN,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: AliceColors.ALICE_GREEN,
                        tabs: [
                          Tab(
                            text: "Agents",
                          ),
                          Tab(
                            text: "Groups",
                          ),
                        ],
                      ),
                      title: Text(
                        'Ressaign Ticket',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      centerTitle: false,
                    ),
                    body: TabBarView(
                      children: [
                        ListView.separated(
                          itemCount: 100,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 0.5,
                              color: Colors.grey,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(""),
                                    radius: 25,
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 30,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AliceColors.ALICE_GREEN,
                                        radius: 10,
                                      ))
                                ],
                              ),
                              title: Text(
                                "Jenny Wilson",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              subtitle: Text(
                                "Active now",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ),
                        ListView.separated(
                          itemCount: 100,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 0.5,
                              color: Colors.grey,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(""),
                                  radius: 25,
                                ),
                                title: Text(
                                  "Jenny Wilson",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}
