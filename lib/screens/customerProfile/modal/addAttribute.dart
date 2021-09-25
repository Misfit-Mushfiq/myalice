import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';

class AddCustomerAttribute extends StatefulWidget {
  Function(String title, String value) onSaved;
  AddCustomerAttribute({Key? key, required this.onSaved}) : super(key: key);

  @override
  _AddCustomerAttributeState createState() => _AddCustomerAttributeState();
}

class _AddCustomerAttributeState extends State<AddCustomerAttribute> {
  bool _visible = false;
  String _title = "";
  String _value = "";
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: 30.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
            )),
        title: Text(
          "New Attribute",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        actions: [
          Visibility(
            visible: _visible,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 15.0, 8.0, 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSaved(_title, _value);
                    Get.back();
                  },
                  child: Text("Save",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: AliceColors.ALICE_GREEN,
                      padding: EdgeInsets.all(5)),
                )),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              textAlign: TextAlign.start,
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 15),
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
                        _title = value;
                        _visible = true;
                      });
                    } else {
                      setState(() {
                        _visible = false;
                      });
                    }
                  },
                  decoration: InputDecoration.collapsed(
                      hintText: "e.g. Name",
                      hintStyle: TextStyle(fontSize: 14)),
                ),
              ),
            ),
            Text(
              "Value",
              textAlign: TextAlign.start,
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 15),
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
                        _value = value;
                        _visible = true;
                      });
                    } else {
                      setState(() {
                        _visible = false;
                      });
                    }
                  },
                  decoration: InputDecoration.collapsed(
                      hintText: "e.g. Value",
                      hintStyle: TextStyle(fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
