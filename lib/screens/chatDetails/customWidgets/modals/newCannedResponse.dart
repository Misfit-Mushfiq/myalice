import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';

class NewCannedResponse extends StatefulWidget {
  final Function(String title, String body, bool team) onSaved;
  NewCannedResponse({Key? key, required this.onSaved}) : super(key: key);

  @override
  _NewCannedResponseState createState() => _NewCannedResponseState();
}

class _NewCannedResponseState extends State<NewCannedResponse> {
  bool _visiblity = false;
  String _text = '';
  String _title = '';
  bool _team = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Wrap(
          children: [Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: AppBar(
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
                        widget.onSaved(_title, _text, _team);
                        Get.back();
                      },
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                          primary: AliceColors.ALICE_GREEN),
                    ),
                  )),
            ],
        ),
          ),
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title"),
                  SizedBox(
                    height: 5,
                  ),
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
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
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
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "e.g. payment",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  ),
                  Text("Response"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    height: 160,
                    child: Card(
                        color: Colors.white,
                        clipBehavior: Clip.hardEdge,
                        elevation: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLines: null,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
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
                            },
                            decoration: InputDecoration.collapsed(
                                hintText: "e.g. We can only accept payment",
                                hintStyle: TextStyle(fontSize: 15)),
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
     
     ],
             ),
      ),
    );
  }
}
