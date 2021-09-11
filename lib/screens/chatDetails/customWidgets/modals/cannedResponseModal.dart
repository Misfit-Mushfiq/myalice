import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';

class CannedResponseModal extends StatefulWidget {
  final CannedResponse cannedResponse;
  CannedResponseModal({Key? key, required this.cannedResponse})
      : super(key: key);

  @override
  _CannedResponseState createState() => _CannedResponseState();
}

class _CannedResponseState extends State<CannedResponseModal> {
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
            return ListTile(
              leading: Text(
                  "#${widget.cannedResponse.dataSource!.elementAt(index).title}"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(thickness: 0.8);
          },
          itemCount: widget.cannedResponse.dataSource!.length),
    );
  }
}
