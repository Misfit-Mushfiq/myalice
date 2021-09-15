import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/models/responseModels/availableAgents/assigned_agents.dart';
import 'package:myalice/models/responseModels/availableGroups/available_groups.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/cannedResponse/data_source.dart';
import 'package:myalice/models/responseModels/channels/channels.dart';
import 'package:myalice/models/responseModels/projectsModels/projects.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/ticketResponse.dart';
import 'package:myalice/screens/inboxScreen/inboxScreen.dart';
import 'package:myalice/utils/shared_pref.dart';

class InboxController extends BaseApiController {
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
  late Projects _projects;
  late Channels _channels;
  late AvailableAgents _agents;
  late AvailableGroups _groups;
  late CannedResponse _cannedResponse;
  late Tags _availableTags;

  var _userDataAvailable = false.obs;
  var isticketsDataAvailable = false.obs;

  bool get userDataAvailable => _userDataAvailable.value;
  UserInfoResponse get user => _user;
  Projects get projects => _projects;
  Channels get channels => _channels;
  AvailableAgents get agents => _agents;
  AvailableGroups get groups => _groups;
  CannedResponse get cannedResponse => _cannedResponse;
  Tags get tags => _availableTags;

  bool get ticketDataAvailable => isticketsDataAvailable.value;
  TicketResponse get tickets => _ticketResponse;

  late String? token;
  static late String _projectID;
  static String get projectId => _projectID;

  static String _projectsPath = "bots/projects";
  static String _accountPath = "accounts/info";
  static String _ticketsPath = "crm/projects/$projectId/tickets";
  static String _channelsPath = "bots/projects/$projectId/platforms/list";
  static String _availableAgentsPath = "bots/projects/$projectId/access";
  static String _availableGroupsPath = "bots/projects/$projectId/groups";
  static String _ticketsTagsPath = "crm/projects/$projectId/ticket-tags";
  static String _cannedResponsePath =
      "crm/projects/$projectId/canned-responses";

  void _updateID(var projectID) {
    _projectID = projectID;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    token = await _sharedPref.readString("apiToken");
    await getUser();
    await getProjects().then((value) {
      if (value!.success!) {
        getChannels();
        getAvailableAgents();
        getAvailableGroups();
        getCannedResponse();
        getTicketTags();
      }
    });
    await _sharedPref.saveBool("sortNew", false);
    await _sharedPref.saveBool("resolvedSelected", false);
    sort = await _sharedPref.readBool("sortNew") ? "asc" : "desc";
    resolved = 0;
    getTickets(
        order: sort,
        resolved: resolved,
        search: "",
        channels: [],
        agents: [],
        groups: [],
        tags: [],
        dates: []);
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

  Future<dynamic> getTickets(
      {required String order,
      required int resolved,
      required String search,
      required List<String> channels,
      required List<String> agents,
      required List<String> groups,
      required List<String> tags,
      required List<String> dates}) async {
    getDio()!
        .get(_ticketsPath,
            queryParameters: {
              "resolved": resolved,
              "offset": 0,
              "limit": 20,
              "search": search,
              "channels": channels.length == 0 ? "all" : channels.join(','),
              "agents": agents.length == 0 ? "all" : agents.join(','),
              "groups": groups.length == 0 ? "all" : groups.join(','),
              "tags": tags.length == 0 ? "all" : tags.join(','),
              "order": order,
              "start": dates!.length > 0 ? dates.elementAt(0) : "",
              "end": dates.length > 0 ? dates.elementAt(1) : ""
            },
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _ticketResponse = TicketResponse.fromJson(response.data)
            : null)
        .catchError((err) => print(err.toString()))
        .whenComplete(
            () => isticketsDataAvailable.value = _ticketResponse != null);
  }

  Future<Projects?> getProjects() async {
    return getDio()!
        .get(_projectsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) async {
      if (response.statusCode == 200) {
        _projects = Projects.fromJson(response.data);
        _updateID(await _sharedPref.readString("projectID") ??
            _projects.dataSource!.elementAt(0).id.toString());
        return _projects;
      }
    });
  }

  Future<Channels?> getChannels() async {
    return getDio()!
        .get(_channelsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ?  _channels = Channels.fromJson(response.data)
            : null);
  }

  Future<AvailableAgents?> getAvailableAgents() async {
    return getDio()!
        .get(_availableAgentsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _agents = AvailableAgents.fromJson(response.data)
            : null)
        .whenComplete(() => _agents);
  }

  Future<AvailableGroups?> getAvailableGroups() async {
    return getDio()!
        .get(_availableGroupsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _groups = AvailableGroups.fromJson(response.data)
            : null)
        .whenComplete(() => _groups);
  }

  Future<Tags?> getTicketTags() async {
    return getDio()!
        .get(_ticketsTagsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _availableTags = Tags.fromJson(response.data)
            : null)
        .whenComplete(() {
      return _availableTags;
    });
  }

  Future<CannedResponse?> getCannedResponse() async {
    return getDio()!
        .get(_cannedResponsePath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        _cannedResponse = CannedResponse.fromJson(response.data);
        SharedPref().saveString("cannedResponse",
            CannedDataSource.encode(_cannedResponse.dataSource!));
        return _cannedResponse;
      }
    });
  }
}
