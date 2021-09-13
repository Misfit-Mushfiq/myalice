import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';

class CannedResponEdit extends StatefulWidget {
  final Function(String text) onSaved;
  CannedResponEdit({Key? key, required this.onSaved}) : super(key: key);

  @override
  _CannedResponEditState createState() => _CannedResponEditState();
}

class _CannedResponEditState extends State<CannedResponEdit> {
  bool _visiblity = false;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Add Note",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              )),
          leadingWidth: 30,
          actions: [
            Visibility(
                visible: _visiblity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSaved(text);
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                        primary: AliceColors.ALICE_GREEN),
                  ),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            height: 200,
            child: Card(
                color: Colors.white,
                clipBehavior: Clip.hardEdge,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: null,
                    autocorrect: true,
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _visiblity = true;
                          text = value;
                        });
                      } else {
                        setState(() {
                          _visiblity = false;
                          text = value;
                        });
                      }
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here"),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
