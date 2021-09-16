import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/projectsModels/data_source.dart';
import 'package:myalice/screens/inboxScreen/inboxScreen.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/routes.dart';
import 'package:myalice/utils/shared_pref.dart';

class TeamSelection extends StatefulWidget {
  final List<ProjectDataSource> teams;
  TeamSelection({Key? key, required this.teams}) : super(key: key);

  @override
  _TeamSelectionState createState() => _TeamSelectionState();
}

class _TeamSelectionState extends State<TeamSelection> {
  int _selectedIndex = -1;
  SharedPref _sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          height: 200,
          child: Center(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.2,
                    color: Colors.grey,
                  );
                },
                itemCount: widget.teams.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0.0,
                    child: ListTile(
                      selected: _selectedIndex == index ? true : false,
                      title: Text(
                        widget.teams.elementAt(index).name!,
                        style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.black,
                            fontWeight: _selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      onTap: () async {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _sharedPref.saveString("projectID",
                            widget.teams.elementAt(index).id.toString());
                        await Get.toNamed(INBOX_PAGE);
                        setState(() {});
                      },
                      trailing: _selectedIndex == index
                          ? Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
