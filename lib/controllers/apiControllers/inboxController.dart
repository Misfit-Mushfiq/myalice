import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/ticketResponse.dart';
import 'package:myalice/utils/shared_pref.dart';

class InboxController extends BaseApiController {
  static String _accountPath = "accounts/info";
  static String _ticketsPath = "crm/projects/81/tickets";

  final SharedPref _sharedPref = SharedPref();

  var _user;
  var _ticketResponse;

  var _userDataAvailable = false.obs;
  var _ticketsDataAvailable = false.obs;

  bool get userDataAvailable => _userDataAvailable.value;
  UserInfoResponse get user => _user;

  bool get ticketDataAvailable => _ticketsDataAvailable.value;
  TicketResponse get tickets => _ticketResponse;

  late String? token;

  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    await getUser();
    getTickets();
  }

  Future<dynamic> getUser() async {
    getDio()!
        .get(_accountPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _user = UserInfoResponse.fromJson(response.data)
            : null)
        .catchError((err) => print('Error!!!!! : $err'))
        .whenComplete(() => _userDataAvailable.value = _user != null);
  }

  Future<dynamic> getTickets() async {
    getDio()!
        .get(_ticketsPath,
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
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _ticketResponse = TicketResponse.fromJson(response.data)
            : null)
        .catchError((err) => print('Error!!!!! : $err'))
        .whenComplete(
            () => _ticketsDataAvailable.value = _ticketResponse != null);
  }
}
