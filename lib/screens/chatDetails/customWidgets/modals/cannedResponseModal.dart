import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/cannedResponse/data_source.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/cannedResponseEdit.dart';
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
            style: TextStyle(color: Colors.black),
          ),
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
                      index);
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
      BuildContext context, String title, String text, int index) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 800),
        backgroundColor: Colors.white,
        builder: (context) {
          return CannedResponsEdit(
            onSaved: (String text, int index) {
              setState(() {
                Get.find<ChatApiController>().deleteCannedResponse(_dataSource.elementAt(index).id.toString());
                _dataSource.removeAt(index);
                SharedPref().saveString(
                    "cannedResponse", CannedDataSource.encode(_dataSource));
              });
            },
            body: text,
            index: index,
            title: title,
          );
        }).whenComplete(() {
      setState(() {});
    });
  }
}
