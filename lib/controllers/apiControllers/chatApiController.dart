import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/db.dart';
import 'package:myalice/utils/shared_pref.dart';

class ChatApiController extends BaseApiController {
  static String _chatPath = "/crm/tickets/932/messenger-chat";
  var chatResponse = <DataSource?>[].obs;
  var dataAvailable = false.obs;
  bool get isDataAvailable => dataAvailable.value;
  List<DataSource?> get chats => chatResponse;
  ChatDataBase _chatDataBase = ChatDataBase();
  final SharedPref _sharedPref = SharedPref();
  late String? token;

  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    getChats();
  }

  void getChats() async {
    getDio()!
        .get(_chatPath,
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

  Future<void> closeDB() async {
    await _chatDataBase.dbClose();
  }
}
