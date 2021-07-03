import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiControlleer.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';

class ChatApiController extends BaseApiController {
  static String _chatPath = "/crm/tickets/932/messenger-chat";
  var _chatResponse;
  var _dataAvailable = false.obs;
  bool get dataAvailable => _dataAvailable.value;
  ChatResponse get chats => _chatResponse;

  @override
  void onInit() {
    super.onInit();
    getChats();
  }

  Future<ChatResponse> getChats() async {
    getDio()!.get(_chatPath).then((value) {
      if (value.statusCode == 200)
        _chatResponse = ChatResponse.fromJson(value.data);
    }).whenComplete(() => _dataAvailable.value = _chatResponse != null);
    return _chatResponse;
  }
}
