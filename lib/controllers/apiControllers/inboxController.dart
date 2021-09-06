import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/availableAgents/assigned_agents.dart';
import 'package:myalice/models/availableGroups/available_groups.dart';
import 'package:myalice/models/channels/channels.dart';
import 'package:myalice/models/projectsModels/projects.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/ticketResponse.dart';
import 'package:myalice/models/tags/tags.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:pusher_client/pusher_client.dart';

class InboxController extends BaseApiController {
  static String _accountPath = "accounts/info";
  static String _ticketsPath = "crm/projects/81/tickets";
  static String _projectsPath = "bots/projects";
  static String _channelsPath = "bots/projects/81/platforms/list";
  static String _availableAgentsPath = "bots/projects/81/access";
  static String _availableGroupsPath = "bots/projects/81/groups";
  static String _ticketsTagsPath = "crm/projects/81/ticket-tags";

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
  late Projects _projectResponse;

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
    getTickets(sort, resolved, "",[],[],[],[]);
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

  Future<dynamic> getTickets(String order, int resolved, String search,List<String> channels,List<String?> agents,List<String?> groups,List<String?> tags) async {
    getDio()!
        .get(_ticketsPath,
            queryParameters: {
              "resolved": resolved,
              "offset": 0,
              "limit": 20,
              "search": search,
              "channels": channels.length==0?"all":channels.join(','),
              "agents": agents.length==0?"all":agents.join(','),
              "groups": groups.length==0?"all":groups.join(','),
              "tags": tags.length==0?"all":tags.join(','),
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

  Future<Projects?> getProjects() async {
    return getDio()!
        .get(_projectsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? Projects.fromJson(response.data)
            : null);
  }

  Future<Channels?> getChannels() async {
    return getDio()!
        .get(_channelsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? Channels.fromJson(response.data)
            : null);
  }

  Future<AssignedAgents?> getAvailableAgents() async {
    return getDio()!
        .get(_availableAgentsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? AssignedAgents.fromJson(response.data)
            : null);
  }

  Future<AvailableGroups?> getAvailableGroups() async {
    return getDio()!
        .get(_availableGroupsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? AvailableGroups.fromJson(response.data)
            : null);
  }

  Future<Tags?> getTicketTags() async {
    return getDio()!
        .get(_ticketsTagsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? Tags.fromJson(response.data)
            : null);
  }
}
