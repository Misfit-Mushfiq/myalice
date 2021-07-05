import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiControlleer.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/db.dart';

class ChatApiController extends BaseApiController {
  static String _chatPath = "/crm/tickets/932/messenger-chat";
  var _chatResponse = ChatResponse().obs;
  var dataAvailable = false.obs;
  bool get isDataAvailable => dataAvailable.value;
  ChatResponse get chats => _chatResponse.value;
  ChatDataBase _chatDataBase = ChatDataBase();

  @override
  void onInit() {
    super.onInit();
    getChats();
  }

  void getChats() async {
    getDio()!.get(_chatPath).then((value) async {
      if (value.statusCode == 200) {
        _chatResponse.update((val) {
          val!.dataSource = ChatResponse.fromJson(value.data).dataSource;
        });
        ChatResponse chatResponse = ChatResponse.fromJson(value.data);

        for (int i = 0; i < chatResponse.dataSource!.length; i++) {
          await _chatDataBase.insertChats(chatResponse.dataSource![i].data);
        }
      }
    }).whenComplete(() => dataAvailable.value = true);
  }

  printChats() {
    return _chatDataBase.getChats();
  }
}
