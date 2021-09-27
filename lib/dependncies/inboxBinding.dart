import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => InboxController());
    Get.put(() => ChatApiController());
  }
}
