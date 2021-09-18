import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/cannedResponse/data_source.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/cannedResponseEdit.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/newCannedResponse.dart';
import 'package:myalice/utils/shared_pref.dart';

class CannedResponseModal extends StatefulWidget {
  final CannedResponse cannedResponse;
  CannedResponseModal({Key? key, required this.cannedResponse})
      : super(key: key);

  @override
  _CannedResponseState createState() => _CannedResponseState();
}

class _CannedResponseState extends State<CannedResponseModal> {
  List<CannedDataSource> _dataSource = <CannedDataSource>[];
  late int? _responseID;
  InboxController _inboxController = Get.find<InboxController>();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    _dataSource = CannedDataSource.decode(
        await SharedPref().readString("cannedResponse"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.grey,
              )),
          title: Text(
            "Canned Response",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _showNewResponse(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "New Response",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )),
            )
          ],
          centerTitle: false,
          leadingWidth: 25.0,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _showResponseEdit(
                      context,
                      _dataSource!.elementAt(index).title!,
                      _dataSource!.elementAt(index).text!,
                      index,
                      _dataSource!.elementAt(index).forTeam!);
                },
                child: ListTile(
                  leading: Text("#${_dataSource!.elementAt(index).title}"),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 0.8);
            },
            itemCount: _dataSource.length));
  }

  _showResponseEdit(
      BuildContext context, String title, String text, int index, bool team) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 800),
        backgroundColor: Colors.white,
        builder: (context) {
          return CannedResponsEdit(
            onDelete: (int index) {
              setState(() {
                try {
                  Get.find<ChatApiController>()
                      .deleteCannedResponse(
                          _dataSource.elementAt(index).id.toString())
                      .then((value) {
                    if (value!) {
                      _dataSource.removeAt(index);
                      SharedPref().saveString("cannedResponse",
                          CannedDataSource.encode(_dataSource));
                    }
                  });
                } catch (e) {}
              });
            },
            body: text,
            index: index,
            title: title,
            team: team,
            onSaved: (String title, String body, bool team, int index) {
              try {
                Get.find<ChatApiController>()
                    .editCannedResponse(
                        _dataSource.elementAt(index).id.toString(),
                        title,
                        body,
                        team)
                    .then((value) {
                  if (value!) {
                    _responseID = _dataSource.elementAt(index).id;
                    _dataSource.removeAt(index);
                    _dataSource.insert(
                        index,
                        CannedDataSource(
                            id: _responseID,
                            title: title,
                            text: body,
                            forTeam: team));
                    SharedPref().saveString(
                        "cannedResponse", CannedDataSource.encode(_dataSource));
                  }
                });
              } catch (e) {}
            },
          );
        }).whenComplete(() {
      setState(() {});
    });
  }

  _showNewResponse(BuildContext context) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 800),
        backgroundColor: Colors.white,
        builder: (context) {
          return NewCannedResponse(
            onSaved: (String title, String body, bool team) {
              Get.find<ChatApiController>()
                  .addCannedResponse(title, body, team)
                  .then((value) {
                if (value!) {
                  _dataSource.add(CannedDataSource(
                      title: title, text: body, forTeam: team));
                  SharedPref().saveString(
                      "cannedResponse", CannedDataSource.encode(_dataSource));
                  _inboxController
                      .getCannedResponse(_inboxController.projectID);
                }
              });
            },
          );
        }).whenComplete(() {
      setState(() {});
    });
  }
}
