import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/loginApiController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => LoginApiController());
  }
}