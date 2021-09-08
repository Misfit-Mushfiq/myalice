import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';

class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InboxController());
  }
}
