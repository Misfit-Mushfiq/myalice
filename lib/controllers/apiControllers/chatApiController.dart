import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as pref;
import 'package:image_picker/image_picker.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/models/responseModels/imageUpload/image_upload.dart';
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
  int get getId => id;
  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    getChats(getId.toString());
  }

  void updateID(var ticketsID) {
    id = ticketsID;
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
          await _chatDataBase.insertChats(response.dataSource![i]);
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

  void sendChats(
    String id,
    String text,
    String image
  ) async {
    getDio()!.post("crm/tickets/$id/messenger-chat",
        data: {"text": text, "image": image, "action": "direct_message"},
        options: Options(headers: {"Authorization": "Token $token"}));
    /* then((value) async {
      if (value.statusCode == 200) {
        ChatResponse response = ChatResponse.fromJson(value.data);
/* _chatResponse.update((val) {
          val!.data = DataSource.fromJson(value.data).data;
        }); */

        for (int i = 0; i < response.dataSource!.length; i++) {
          await _chatDataBase.insertChats(response.dataSource![i]);
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
    }); */
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
        .post("api/crm/tickets/$id/tag",
            data: {"action": action, "name": name, "id": tagId},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }

  Future<bool?> removeTicketTags(String action, String name, int tagId) async {
    return getDio()!
        .post("api/crm/tickets/$id/tag",
            data: {"action": action, "name": name, "id": tagId},
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null);
  }
}
