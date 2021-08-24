import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/utils/shared_pref.dart';

class InboxController extends BaseApiController {
  static String _accountPath = "accounts/info";
  static String _ticketsPath = "crm/projects/81/tickets";

  final SharedPref _sharedPref = SharedPref();
  var userResponse = UserInfoResponse().obs;
  var dataAvailable = false.obs;
  bool get isDataAvailable => dataAvailable.value;
  UserInfoResponse get user => userResponse.value;

  late String? token;

  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    await getUser();
    getTickets();
  }

  Future<dynamic> getUser() async {
    final response = await getDio()!.get(_accountPath,
        options: Options(headers: {"Authorization": "Token $token"}));
    if (response.statusCode == 200) {
      change(response, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(response.statusMessage));
    }
  }

  Future<dynamic> getTickets() async {
    final response = await getDio()!.get(_ticketsPath,
        queryParameters: {
          "resolved": 0,
          "offset": 0,
          "limit": 20,
          "search": "",
          "channels": "all",
          "agents": "all",
          "groups": "all",
          "tags": "all",
          "order": "desc"
        },
        options: Options(headers: {"Authorization": "Token $token"}));
    if (response.statusCode == 200) {
      change(response, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(response.statusMessage));
    }
  }
}
