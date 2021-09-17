import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/utils/colors.dart';

class EditCustomerInfo extends StatefulWidget {
  EditCustomerInfo({Key? key}) : super(key: key);

  @override
  _EditCustomerInfoState createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<EditCustomerInfo> {
  String _dropDownValue = "";
  late Map _userData;
  var _id;
  @override
  void initState() {
    var args = Get.arguments;
    _userData = args[0];
    _dropDownValue = _userData["gender"];
    _id = args[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Information",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          elevation: 0.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              )),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full name",
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
                        initialValue: _userData["full_name"],
                        onChanged: (String value) {
                          setState(() {
                            _userData["full_name"] = value;
                          });
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your first name",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Text(
                    "Gender",
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: DropdownButton(
                        hint: _dropDownValue == null
                            ? Text('Dropdown')
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 5.0, 8.0, 5.0),
                                child: Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                        isExpanded: true,
                        underline: Container(),
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.black),
                        items: ['Male', 'Female', 'Other'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val.toString();
                              _userData["gender"] = _dropDownValue;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    "Phone",
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
                        initialValue: _userData["phone"],
                        keyboardType: TextInputType.phone,
                        onChanged: (String value) {
                          setState(() {
                            _userData["phone"] = value;
                          });
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Text(
                    "Email",
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
                        initialValue: _userData["email"],
                        onChanged: (String value) {
                          setState(() {
                            _userData["email"] = value;
                          });
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  Text(
                    "Locale",
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
                        initialValue: _userData["locale"],
                        onChanged: (String value) {
                          setState(() {
                            _userData["locale"] = value;
                          });
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter locale",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.find<CustomerProfileController>()
                              .editUserInfo(
                                  customerID: _id.toString(), info: _userData)
                              .then((value) {
                            if (value) {
                              Get.back(result: true);
                            }
                          });
                        },
                        child: Text("Save Changes"),
                        style: ElevatedButton.styleFrom(
                            primary: AliceColors.ALICE_GREEN),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
