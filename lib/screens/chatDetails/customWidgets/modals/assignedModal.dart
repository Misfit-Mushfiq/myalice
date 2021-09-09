import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';

class InboxAssignedModal extends StatefulWidget {
  InboxAssignedModal({Key? key}) : super(key: key);

  @override
  _AssignedModalState createState() => _AssignedModalState();
}

class _AssignedModalState extends State<InboxAssignedModal> {
  @override
  Widget build(BuildContext context) {
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
                                  backgroundColor: AliceColors.ALICE_GREEN,
                                  radius: 10,
                                ))
                          ],
                        ),
                        title: Text(
                          "Jenny Wilson",
                          style: TextStyle(color: Colors.black, fontSize: 15),
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
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(""),
                            radius: 25,
                          ),
                          title: Text(
                            "Jenny Wilson",
                            style: TextStyle(color: Colors.black, fontSize: 15),
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
  }
}
