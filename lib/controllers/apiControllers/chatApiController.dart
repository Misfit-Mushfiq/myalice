import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as pref;
import 'package:image_picker/image_picker.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/models/responseModels/imageUpload/image_upload.dart';
import 'package:myalice/models/responseModels/noteResponse/note_response.dart';

import 'package:myalice/models/responseModels/sendChats/send_data.dart';
import 'package:myalice/models/responseModels/ticketMeta/customer_meta.dart';
import 'package:myalice/utils/db.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:http_parser/http_parser.dart';

class ChatApiController extends BaseApiController {
  var chatResponse = <DataSource?>[].obs;
  var dataAvailable = false.obs;
  bool get isDataAvailable => dataAvailable.value;
  List<DataSource?> get chats => chatResponse;
  ChatDataBase _chatDataBase = ChatDataBase();
  final SharedPref _sharedPref = SharedPref();
  late String? token;
  int id = 0;
  int customerID = 0;
  int get getId => id;
  int get getCustomerID => customerID;
  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    getMeta(customerID: getCustomerID.toString());
    getChats(getId.toString());
  }

  void updateID(var ticketsID) {
    id = ticketsID;
  }
  void updateCustomerID(var id) {
    customerID = id;
  }

  void getChats(String id) async {
    getDio()!
        .get("crm/tickets/$id/messenger-chat",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((value) async {
      if (value.statusCode == 200) {
        ChatResponse response = ChatResponse.fromJson(value.data);
/* _chatResponse.update((val) {
          val!.data = DataSource.fromJson(value.data).data;
        }); */

        for (int i = 0; i < response.dataSource!.length; i++) {
          _chatDataBase.insertChats(response.dataSource![i]);
        }
        _chatDataBase.getChats().then((value) {
          for (int i = 0; i < value.length; i++) {
            chatResponse.add(value[i]);
          }
        });
      }
    }).whenComplete(() {
      dataAvailable.value = true;
      chatResponse.refresh();
    });
  }

  Future<SendData> sendChats(String id, String text, String image) async {
    return getDio()!
        .post("crm/tickets/$id/messenger-chat",
            data: {"text": text, "image": image, "action": "direct_message"},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((value) {
      if (value.statusCode == 200) {
        if (value.data["success"]) {
          return SendData.fromJson(value.data);
        }
      }
      return SendData.fromJson(value.data["success"]);
    });
  }

  Future<void> closeDB() async {
    await _chatDataBase.dbClose();
  }

  Future<ImageUpload> uploadPhoto(XFile imageFile) async {
    String fileName = imageFile.path.split('/').last;
    String fileExt = imageFile.path.split('.').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path,
          filename: fileName, contentType: MediaType("image", fileExt)),
    });
    Response response = await getDio()!.post(
      "crm/projects/81/images",
      options: Options(headers: {
        'Authorization': 'Token $token',
      }),
      data: formData,
    );
    if (response.statusCode == 200)
      return ImageUpload.fromJson(response.data);
    else {
      return ImageUpload.fromJson(response.data);
    }
  }

  /*  Future<dynamic> uploadImage(XFile file) async {
    String fileName = file.path.split('/').last;
    print("FileName::$fileName");
    print("FilePath::${file.path}");

    

    Uint8List uint8list = await file.readAsBytes();

    var image =
        XFile.fromData(uint8list, mimeType: file.mimeType, name: fileName);
         FormData formData = FormData.fromMap({
      "file": image,
    }); 
    print(formData.files);
    var response = await getDio()!.post("crm/projects/81/images",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
            headers: {"Authorization": "Token $token"}));
    return response.data;
  }

   */
  Future<bool?> addTicketTags(String action, String name, int tagId) async {
    return getDio()!
        .post("crm/tickets/$id/tag",
            data: {"action": action, "name": name, "id": tagId},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> removeTicketTags(
      {required String action,
      required String name,
      required int tagId}) async {
    return getDio()!
        .post("crm/tickets/$id/tag",
            data: {"action": action, "name": name, "id": tagId},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> reassign(String agentID, String groupID) async {
    return getDio()!
        .post("crm/tickets/$id/action-assign",
            data: {"agent_id": agentID, "group_id": groupID},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<NoteResponse> saveNote(String note) async {
    return getDio()!
        .post("crm/tickets/$id/messenger-chat",
            data: {"text": note, "image": null, "action": "write_note"},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? NoteResponse.fromJson(response.data)
            : NoteResponse.fromJson(response.data));
  }

  Future<bool?> deleteCannedResponse(String responseID) async {
    return getDio()!
        .delete("crm/projects/$id/canned-responses/$responseID",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> editCannedResponse(
      String responseID, String title, String body, bool team) async {
    return getDio()!
        .patch("crm/projects/$id/canned-responses/$responseID",
            data: {"title": title, "text": body, "for_team": team},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> addCannedResponse(String title, String body, bool team) async {
    return getDio()!
        .post("crm/projects/81/canned-responses",
            data: {
              "title": title,
              "text": body,
              "for_team": team,
              "teamId": "81"
            },
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> resolveTicket() async {
    return getDio()!
        .post("crm/tickets/$id/action-resolve",
            data: {"status": true},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> actionBot(bool status) async {
    return getDio()!
        .post("crm/tickets/$id/action-bot",
            data: {"status": status},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<CustomerMeta?> getMeta({String? customerID}) async {
    return getDio()!
        .get("bots/customers/$customerID/meta",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        var meta = CustomerMeta.fromJson(response.data);
        SharedPref().saveBool("bot${meta.data!.id}", meta.data!.botEnabled!);
      }
    });
  }
}
