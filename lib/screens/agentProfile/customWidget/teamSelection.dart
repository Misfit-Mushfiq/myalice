import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/projectsModels/data_source.dart';
import 'package:myalice/screens/inboxScreen/inboxScreen.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TeamSelection extends StatefulWidget {
  final List<ProjectDataSource> teams;
  TeamSelection({Key? key, required this.teams}) : super(key: key);

  @override
  _TeamSelectionState createState() => _TeamSelectionState();
}

class _TeamSelectionState extends State<TeamSelection> {
  int _selectedIndex = -1;
  SharedPref _sharedPref = SharedPref();
  String _projectID = '';
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    getProjectID();
  }

  void scrollTo(int index) {
    _itemScrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeInOutCubic);
  }

  Future<void> getProjectID() async {
    _projectID = await _sharedPref.readString("projectID") ?? widget.teams.elementAt(0).id.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        height: 200,
        child: Center(
            child: ScrollablePositionedList.separated(
                physics: BouncingScrollPhysics(),
                itemCount: widget.teams.length,
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
                itemBuilder: (context, index) {
                  if (widget.teams.elementAt(index).id.toString() ==
                      _projectID) {
                    scrollTo(index);
                  }
                  return Card(
                    elevation: 0.0,
                    child: ListTile(
                      selected: widget.teams.elementAt(index).id.toString() ==
                              _projectID
                          ? true
                          : false,
                      title: Text(
                        widget.teams.elementAt(index).name!,
                        style: TextStyle(
                            color:
                                widget.teams.elementAt(index).id.toString() ==
                                        _projectID
                                    ? Colors.black
                                    : Colors.black,
                            fontWeight:
                                widget.teams.elementAt(index).id.toString() ==
                                        _projectID
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                      ),
                      onTap: () async {
                        setState(() {
                          _selectedIndex = index;
                        });
                        await _sharedPref.saveString("projectID",
                            widget.teams.elementAt(index).id.toString());
                        await _sharedPref.saveString(
                            "projectName", widget.teams.elementAt(index).name);
                        _sharedPref.remove("pendingSelected");
                        _sharedPref.remove("resolvedSelected");
                        _sharedPref.remove("sortNew");
                        Get.offAllNamed(INBOX_PAGE);
                      },
                      trailing: widget.teams.elementAt(index).id.toString() ==
                              _projectID
                          ? Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.2,
                    color: Colors.grey,
                  );
                })),
      ),
    ));
  }
}
