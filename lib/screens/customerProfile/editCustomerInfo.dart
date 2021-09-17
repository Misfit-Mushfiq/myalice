import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/screens/customerProfile/modal/addAttribute.dart';
import 'package:myalice/utils/colors.dart';

class EditCustomerInfo extends StatefulWidget {
  EditCustomerInfo({Key? key}) : super(key: key);

  @override
  _EditCustomerInfoState createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<EditCustomerInfo> {
  String _dropDownValue = "";
  late Map _userData;
  late var _attributes = Map().obs;
  var _id;
  @override
  void initState() {
    var args = Get.arguments;
    _userData = args[0];
    _dropDownValue = _userData["gender"];
    _id = args[1];
    _attributes.value = args[2];
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
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 15.0, 8.0, 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showModal(context);
                  },
                  child: Text("+ New Attribute",
                      style: TextStyle(color: Colors.black87, fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(5)),
                ))
          ],
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
                  Obx(() {
                    if (_attributes.length > 0) {
                      return ListView.builder(
                          itemCount: _attributes.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String key = _attributes.keys.elementAt(index);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  key,
                                  textAlign: TextAlign.start,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 15),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            maxLines: 1,
                                            initialValue: _attributes[key],
                                            onChanged: (String value) {
                                              _attributes[key] = value;
                                            },
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText:
                                                        "Enter your first name",
                                                    hintStyle: TextStyle(
                                                        fontSize: 14)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _userData.addAll(_attributes);
                                          _attributes.remove(key);
                                          _userData.update(
                                              key, (value) => null);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                )
                              ],
                            );
                          });
                    } else {
                      _attributes.clear();
                      return Container();
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _attributes.forEach((key, value) {
                            // print(key);
                            _userData.addAll({key: value});
                          });

                          Get.find<CustomerProfileController>()
                              .editUserInfo(
                                  customerID: _id.toString(), info: _userData)
                              .then((value) {
                            if (value) {
                              Get.back(result: true);
                            }
                          });

                          /* _userData.forEach((key, value) {
                            print(key + " " + value.toString());
                          }); */
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

  _showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 250),
        builder: (context) {
          return AddCustomerAttribute(
            onSaved: (String title, String value) {
              _attributes.value.addAll({title: value});
            },
          );
        });
  }
}
