import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/agentProfileController.dart';
import 'package:myalice/customWidgets/botButton.dart';
import 'package:myalice/models/responseModels/UserResponse.dart';
import 'package:myalice/models/responseModels/projectsModels/projects.dart';
import 'package:myalice/screens/agentProfile/customWidget/teamSelection.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentProfile extends StatefulWidget {
  AgentProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AgentProfile> {
  bool _pushNotification = false;
  bool _incomingTickets = false;
  bool _incomingMesaage = false;
  late UserInfoResponse _userInfoResponse;
  late Projects _projects;
  String _projectName = "";
  SharedPref _sharedPref = SharedPref();
  AgentProfileController _controller = Get.put(AgentProfileController());
  bool _online = true;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _userInfoResponse = Get.arguments[0];
    _projects = Get.arguments[1];
    getProjectName();
    _initPackageInfo();
  }

  Future<void> getProjectName() async {
    _projectName = await _sharedPref.readString("projectName") ??
        _projects.dataSource!.elementAt(0).name!;
    _online = _userInfoResponse.dataSource!.status == "online" ? true : false;
    setState(() {});
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
  
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: CachedNetworkImageProvider(
                              _userInfoResponse.dataSource!.avatar!),
                        ),
                        Positioned(
                            top: 52,
                            left: 45,
                            child: CircleAvatar(
                              child: CircleAvatar(
                                backgroundColor: _online
                                    ? AliceColors.ALICE_GREEN
                                    : Colors.grey,
                                radius: 7,
                              ),
                              radius: 10,
                              backgroundColor: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _userInfoResponse.dataSource!.fullName!,
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          _showTeamModal(context, _projects);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: AliceColors.ALICE_GREY,
                            padding: EdgeInsets.all(2.0),
                            elevation: 1.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _projectName,
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                    Text(_userInfoResponse.dataSource!.email!),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///PRIVACY///
                        Text(
                          "PRIVACY",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.notifications_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Notifications",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            _showModal(context);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.person_outline_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                      _online
                                          ? "Set yourself as Away"
                                          : "Set yourself as Active",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              CupertinoSwitch(
                                activeColor: AliceColors.ALICE_GREEN,
                                onChanged: (values) {
                                  _controller
                                      .changeStatus(_online ? "away" : "online")
                                      .then((value) {
                                    if (value != null && value == "online") {
                                      setState(() {
                                        _online = true;
                                      });
                                    } else {
                                      setState(() {
                                        _online = false;
                                      });
                                    }
                                  });
                                },
                                value: _online ? true : false,
                              )
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        ///MORE///
                        Text(
                          "MORE",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.menu_book_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Terms & Conditions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            launch("https://myalice.ai/terms/");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.comment_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Help & Support",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.article_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("Documentation",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            _launchURL("https://docs.myalice.ai");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.info_outline_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text("About this app",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Text(
                                _packageInfo.version,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon((Icons.arrow_forward_ios),
                                  size: 15, color: Colors.grey)
                            ],
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextButton(
                          child: Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {
                            _controller.logOut().then((value) {
                              if (value != null && value) {
                                _sharedPref.clear();
                                Get.offAllNamed(LOGIN_PAGE);
                              }
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Push Notification"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _pushNotification,
                                valueChanged: (value) {
                                  _pushNotification = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Incoming Ticket"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _incomingTickets,
                                valueChanged: (value) {
                                  _incomingTickets = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Incoming Message"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              BottomSheetSwitch(
                                switchValue: _incomingMesaage,
                                valueChanged: (value) {
                                  _incomingMesaage = value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showTeamModal(BuildContext context, Projects projects) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return TeamSelection(teams: projects.dataSource!);
        });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
