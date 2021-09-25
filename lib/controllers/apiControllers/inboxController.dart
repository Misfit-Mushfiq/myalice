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
  late TicketResponse _ticketResponse;
  late Projects _projects;
  late Channels _channels;
  late AvailableAgents _agents;
  late AvailableGroups _groups;
  late CannedResponse _cannedResponse;
  late Tags _availableTags;

  var _userDataAvailable = false.obs;
  var _isticketsDataAvailable = false.obs;
  var _isTagsAvailable = false.obs;
  var _isCannedResponseAvailable = false.obs;
  var _isAgentsAvailable = false.obs;
  var _isGroupsAvailable = false.obs;

  Projects get projects => _projects;
  Channels get channels => _channels;

  AvailableGroups get groups => _groups;
  bool get groupaAvailable => _isGroupsAvailable.value;
  set groupaAvailable(bool value) {
    _isGroupsAvailable.value = value;
  }

  AvailableAgents get agents => _agents;
  bool get agentsAvailable => _isAgentsAvailable.value;

  UserInfoResponse get user => _user;
  bool get userDataAvailable => _userDataAvailable.value;

  Tags get tags => _availableTags;
  bool get tagsAvailable => _isTagsAvailable.value;
  set tagsAvailable(bool value) {
    _isTagsAvailable.value = value;
  }

  bool get ticketDataAvailable => _isticketsDataAvailable.value;
  set ticketDataAvailable(bool value) {
    _isticketsDataAvailable.value = value;
  }

  TicketResponse get tickets => _ticketResponse;

  CannedResponse get cannedResponse => _cannedResponse;
  bool get cannedResponseAvailable => _isCannedResponseAvailable.value;
  set cannedResponseAvailable(bool value) {
    _isCannedResponseAvailable.value = value;
  }

  late String? token;
  late String _projectId;

  String get projectID {
    return _projectId;
  }

  set projectID(String id) {
    this._projectId = id;
  }

  static String _projectsPath = "bots/projects";
  static String _accountPath = "accounts/info";

  Future<void> onInit() async {
    token = await _sharedPref.readString("apiToken");
    await getUser();
    await getProjects().then((value) {
      if (value!.success!) {
        getChannels(projectID).whenComplete(() => getAvailableAgents(projectID)
            .whenComplete(() => getAvailableGroups(projectID))
            .whenComplete(() => getTicketTags(projectID)
                .whenComplete(() => getCannedResponse(projectID))));
      }
    });
    await _sharedPref.saveBool("sortNew", false);
    await _sharedPref.saveBool("resolvedSelected", false);
    sort = await _sharedPref.readBool("sortNew") ? "asc" : "desc";
    resolved = 0;
    getTickets(
        projectID: projectID,
        order: sort,
        resolved: resolved,
        search: "",
        channels: [],
        agents: [],
        groups: [],
        tags: [],
        dates: []);
    super.onInit();
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
      {required String projectID,
      required String order,
      required int resolved,
      required String search,
      required List<String> channels,
      required List<String> agents,
      required List<String> groups,
      required List<String> tags,
      required List<String> dates}) async {
    ticketDataAvailable = false;
    getDio()!
        .get("crm/projects/$projectID/tickets",
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
        .then((response) {
          if (response.statusCode == 200) {
            _ticketResponse = TicketResponse.fromJson(response.data);
          } else {
            return null;
          }
        })
        .catchError((err) => print(err.toString()))
        .whenComplete(() => ticketDataAvailable =
            _ticketResponse.dataSource!.length > 0 ? true : false);
  }

  Future<Projects?> getProjects() async {
    return getDio()!
        .get(_projectsPath,
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) async {
      if (response.statusCode == 200) {
        _projects = Projects.fromJson(response.data);
        projectID = await _sharedPref.readString("projectID") ??
            _projects.dataSource!.elementAt(0).id.toString();
        return _projects;
      }
    });
  }

  Future<Channels?> getChannels(String projectID) async {
    return getDio()!
        .get("bots/projects/$projectID/platforms/list",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _channels = Channels.fromJson(response.data)
            : null);
  }

  Future<AvailableAgents?> getAvailableAgents(String projectID) async {
    return getDio()!
        .get("bots/projects/$projectID/access",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        _agents = AvailableAgents.fromJson(response.data);
        _isAgentsAvailable.value = true;
      }
    }).whenComplete(() => _agents);
  }

  Future<AvailableGroups?> getAvailableGroups(String projectID) async {
    return getDio()!
        .get("bots/projects/$projectID/groups",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) => response.statusCode == 200
            ? _groups = AvailableGroups.fromJson(response.data)
            : null)
        .whenComplete(() => _groups);
  }

  Future<Tags?> getTicketTags(String projectID) async {
    return getDio()!
        .get("crm/projects/$projectID/ticket-tags",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        _availableTags = Tags.fromJson(response.data);
        _isTagsAvailable.value = true;
        return _availableTags;
      }
    });
  }

  Future<CannedResponse?> getCannedResponse(String projectID) async {
    return getDio()!
        .get("crm/projects/$projectID/canned-responses",
            options: Options(headers: {"Authorization": "Token $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        _cannedResponse = CannedResponse.fromJson(response.data);
        _isCannedResponseAvailable.value = true;
        SharedPref().saveString("cannedResponse",
            CannedDataSource.encode(_cannedResponse.dataSource!));
        return _cannedResponse;
      }
    });
  }
}
