import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/projectsModels/projects.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/ticketResponse.dart';
import 'package:myalice/utils/shared_pref.dart';

class InboxController extends BaseApiController {
  static String _accountPath = "accounts/info";
  static String _ticketsPath = "crm/projects/81/tickets";
  static String _projectsPath = "bots/projects";

  final SharedPref _sharedPref = SharedPref();

  var _sort;
  var _resolved;

  get sort => _sort;
  get resolved => _resolved;

  set resolved(resolved) {
    _resolved = resolved;
  }

  set sort(sort) {
    _sort = sort;
  }

  var _user;
  var _ticketResponse;
  var _projectResponse;

  var _userDataAvailable = false.obs;
  var isticketsDataAvailable = false.obs;

  bool get userDataAvailable => _userDataAvailable.value;
  UserInfoResponse get user => _user;

  bool get ticketDataAvailable => isticketsDataAvailable.value;
  TicketResponse get tickets => _ticketResponse;



  late String? token;

  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    await getUser();
    await getProjects();
    await _sharedPref.saveBool("sortNew", false);
    await _sharedPref.saveBool("resolvedSelected", false);
    sort = await _sharedPref.readBool("sortNew") ? "asc" : "desc";
    resolved = 0;
    getTickets(sort, resolved, "");
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

  Future<dynamic> getTickets(String order, int resolved, String search) async {
    getDio()!
        .get(_ticketsPath,
            queryParameters: {
              "resolved": resolved,
              "offset": 0,
              "limit": 20,
              "search": search,
              "channels": "all",
              "agents": "all",
              "groups": "all",
              "tags": "all",
              "order": order
            },
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _ticketResponse = TicketResponse.fromJson(response.data)
            : null)
        .catchError((err) => _ticketResponse)
        .whenComplete(
            () => isticketsDataAvailable.value = _ticketResponse != null);
  }

  Future<dynamic> getProjects() async {
    getDio()!
        .get(_projectsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _projectResponse = Projects.fromJson(response.data)
            : null)
        .whenComplete(
            () => _projectResponse);
  }
}
