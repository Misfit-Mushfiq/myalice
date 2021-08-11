import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/pusherController.dart';
import 'package:myalice/custom%20widgets/botButton.dart';
import 'package:myalice/models/chatModel/chat.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/colors.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
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
  late TabController _tabController = TabController(length: 2, vsync: this);

  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Object?> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
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
            color: Colors.white,
            height: 300,
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
                          Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  MultiSelectChipField(
                                    items: _items,
                                    initialValue: _selectedAnimals2,
                                    title: Text("Used Tags",style: TextStyle(fontSize: 14),),
                                    headerColor: Colors.white,
                                    chipShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                   decoration: BoxDecoration(),
                                   
                                    selectedChipColor:
                                        AliceColors.ALICE_GREEN,
                                    selectedTextStyle:
                                        TextStyle(color: Colors.white),
                                    onTap: (values) {
                                      _selectedAnimals2 = values;
                                    },
                                    icon: Icon(Icons.cancel,color: Colors.white,),
                                    
                                  ),
                                  /* _selectedAnimals2.isEmpty
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
                                      _selectedAnimals2.remove(value);
                                    });
                                  },
                                ), */
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
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
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      centerTitle: false,
                    ),
                    body: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "items: $index",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            );
                          },
                        ),
                        Icon(Icons.directions_transit),
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
