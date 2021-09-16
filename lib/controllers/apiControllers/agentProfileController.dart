import 'package:dio/dio.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/utils/shared_pref.dart';

class AgentProfileController extends BaseApiController {
  var _token;
  SharedPref _sharedPref = SharedPref();

  @override
  Future<void> onInit() async {
    _token = await _sharedPref.readString("apiToken");
    super.onInit();
  }

  Future<dynamic> logOut() async {
    return getDio()!
        .post("accounts/logout",
            options: Options(headers: {"Authorization": "Token $_token"}))
        .then((response) =>
            response.statusCode == 200 ? response.data["success"] : null)
        .catchError((err) => print('Error!!!!! : $err'));
  }
}
