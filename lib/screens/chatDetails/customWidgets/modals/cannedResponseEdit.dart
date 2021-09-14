import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/utils/colors.dart';

class CannedResponsEdit extends StatefulWidget {
  final Function(int index) onDelete;
  final Function(String title, String body, bool team, int index) onSaved;
  final title;
  final body;
  final index;
  final team;
  CannedResponsEdit(
      {Key? key,
      required this.onDelete,
      required this.onSaved,
      required this.body,
      required this.index,
      required this.title,
      required this.team})
      : super(key: key);

  @override
  _CannedResponEditState createState() => _CannedResponEditState();
}

class _CannedResponEditState extends State<CannedResponsEdit> {
  bool _visiblity = false;
  String _text = '';
  String _title = '';
  late bool _team;

  @override
  void initState() {
    _text = widget.body;
    _title = widget.title;
    _team = widget.team;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Canned Response",
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
                      Get.back();
                      widget.onSaved(_title, _text, _team, widget.index);
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                        primary: AliceColors.ALICE_GREEN),
                  ),
                )),
            IconButton(
                onPressed: () {
                  widget.onDelete(widget.index);
                  Get.back();
                },
                icon: Icon(Icons.delete, color: Colors.grey))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: widget.title,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            if (widget.title != value) {
                              setState(() {
                                _visiblity = true;
                                _title = value;
                              });
                            } else {
                              setState(() {
                                _visiblity = false;
                                _title = value;
                              });
                            }
                          }
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                      ),
                    ),
                  ),
                ),
                Container(
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
                        child: TextFormField(
                          maxLines: null,
                          initialValue: widget.body,
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              if (widget.body != value) {
                                setState(() {
                                  _visiblity = true;
                                  _text = value;
                                });
                              } else {
                                setState(() {
                                  _visiblity = false;
                                  _text = value;
                                });
                              }
                            }
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter your text here"),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio<bool>(
                              activeColor: AliceColors.ALICE_GREEN,
                              value: true,
                              groupValue: _team,
                              onChanged: (index) {
                                setState(() {
                                  _team = index!;
                                  _visiblity = true;
                                });
                              }),
                          Expanded(
                              child: Text(
                            'For Team',
                            maxLines: 2,
                          ))
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Radio<bool>(
                              activeColor: AliceColors.ALICE_GREEN,
                              value: false,
                              groupValue: _team,
                              onChanged: (index) {
                                setState(() {
                                  _team = index!;
                                  _visiblity = true;
                                });
                              }),
                          Text('For Individual')
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
