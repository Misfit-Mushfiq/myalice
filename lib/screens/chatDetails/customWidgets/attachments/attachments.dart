import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/cannedResponseModal.dart';
import 'package:myalice/screens/chatDetails/customWidgets/modals/noteModal.dart';
import 'package:myalice/utils/colors.dart';

class Attachments extends StatefulWidget {
  final String ticketId;
  final CannedResponse cannedResponse;
  Attachments({Key? key, required this.ticketId, required this.cannedResponse})
      : super(key: key);

  @override
  _AttachmentsState createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments> {
  final ImagePicker _picker = ImagePicker();
  var imageFile;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            /* Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AliceColors.ALICE_GREEN),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.attachment,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 5.0, 8.0, 5.0),
                                    child: Center(
                                        child: Text(
                                      "Attach",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            */
            InkWell(
              onTap: () {
                return _showSelectionDialog(context);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AliceColors.ALICE_GREEN),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.image,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Center(
                          child: Text(
                        "Image",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _showCannedResponseModal(context, widget.cannedResponse);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AliceColors.ALICE_GREEN),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.message,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 2.0),
                      child: Center(
                          child: Text(
                        "Canned\nResponse",
                        textAlign: TextAlign.center,
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _showNoteModal(context);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AliceColors.ALICE_GREEN),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.note,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Center(
                          child: Text(
                        "Note",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ListBody(
                  children: <Widget>[
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Gallery"),
                      ),
                      onTap: () {
                        _openGallery(context).then((value) =>
                            Get.find<ChatApiController>()
                                .uploadPhoto(value)
                                .then((value) {
                              if (value.success!) {
                                Get.find<ChatApiController>()
                                    .sendChats(widget.ticketId, "",
                                        value.dataSource!.s3Url!)
                                    .then((value) {
                                  if (value.success!) {
                                    Get.find<ChatApiController>()
                                        .chatResponse
                                        .add(DataSource.fromJson({
                                          "text": "",
                                          "source": value.dataSource!.source!,
                                          "sub_type":
                                              value.dataSource!.data!.type ==
                                                      "attachment"
                                                  ? value.dataSource!.data!
                                                      .data!.subType
                                                  : "",
                                          "type": value.dataSource!.data!.type,
                                          "image_url":
                                              value.dataSource!.data!.type ==
                                                      "attachment"
                                                  ? value.dataSource!.data!
                                                      .data!.urls!
                                                      .elementAt(0)
                                                  : ""
                                        }));
                                  }
                                });
                              }
                              Get.back();
                            }));
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Camera"),
                      ),
                      onTap: () {
                        //_openCamera(context);
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  _showCannedResponseModal(
      BuildContext context, CannedResponse cannedResponse) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (context) {
          return CannedResponseModal(
            cannedResponse: cannedResponse,
          );
        });
  }

  _showNoteModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 200),
        isDismissible: true,
        builder: (context) {
          return NoteModal(
            onSaved: (String note) {
              
              Get.find<ChatApiController>().saveNote(note).then((value) {
                if (value.success!) {
                  Get.find<ChatApiController>()
                      .chatResponse
                      .add(DataSource.fromJson({
                        "text": note,
                        "source": value.dataSource!.source!,
                        "sub_type": value.dataSource!.data!.data!.subType,
                        "type": value.dataSource!.data!.type,
                        "image_url": ""
                      }));
                }
              });
            },
          );
        });
  }

  Future<XFile> _openGallery(BuildContext context) async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    return picture!;
  }
}
