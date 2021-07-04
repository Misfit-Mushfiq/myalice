import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiControlleer.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';

class ChatApiController extends BaseApiController {
  static String _chatPath = "/crm/tickets/932/messenger-chat";
  var chatResponse;
  var dataAvailable = false.obs;
  bool get isDataAvailable => dataAvailable.value;
  ChatResponse get chats => chatResponse;
  var chatModel = ChatResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getChats();
  }

  Future<ChatResponse> getChats() async {
    getDio()!.get(_chatPath).then((value) {
      if (value.statusCode == 200)
        chatResponse = ChatResponse.fromJson(value.data);
    }).whenComplete(() => dataAvailable.value = chatResponse != null);
    return chatResponse;
  }
}
