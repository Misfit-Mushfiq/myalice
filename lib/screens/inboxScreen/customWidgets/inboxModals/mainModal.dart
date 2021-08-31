import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/filterModal.dart';

class MainModal extends StatefulWidget {
  final InboxController inboxController;
  MainModal({Key? key, required this.inboxController}) : super(key: key);

  @override
  _MainModalState createState() => _MainModalState();
}

class _MainModalState extends State<MainModal> {
  bool _pendingSelected = true;
  bool _resolvedSelected = false;
  bool _sortNew = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                _pendingSelected ? " Resolved Tickets" : " Pending Tickets",
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                _pendingSelected
                    ? Icons.check_circle_outline
                    : Icons.lock_clock,
                color: Colors.black,
                size: 25,
              ),
              minLeadingWidth: 0.0,
              contentPadding: EdgeInsets.only(left: 10.0),
              onTap: () {
                setState(() {
                  _pendingSelected = !_pendingSelected;
                  _resolvedSelected = !_resolvedSelected;
                  widget.inboxController.isticketsDataAvailable.value = false;
                  _resolvedSelected
                      ? widget.inboxController.resolved = 1
                      : widget.inboxController.resolved = 0;
                  widget.inboxController.getTickets(widget.inboxController.sort,
                      widget.inboxController.resolved);
                });
                Navigator.of(context).pop();
              },
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10.0),
              title: Text(
                "Filter Tickets",
                style: TextStyle(fontSize: 14),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/launch_icon/filter.svg",
                    color: Colors.black, height: 15),
              ),
              minLeadingWidth: 0.0,
              onTap: () {
                Get.back();
                showFilterModal(context);
              },
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10.0),
              title: _sortNew
                  ? Text(
                      "Sort by newest",
                      style: TextStyle(fontSize: 14),
                    )
                  : Text(
                      "Sort by oldest",
                      style: TextStyle(fontSize: 14),
                    ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/launch_icon/descending.svg",
                  color: Colors.black,
                  height: 15,
                ),
              ),
              minLeadingWidth: 0.0,
              onTap: () {
                Get.back();
                setState(() {
                  _sortNew = !_sortNew;
                  widget.inboxController.isticketsDataAvailable.value = false;
                  _sortNew
                      ? widget.inboxController.sort = "asc"
                      : widget.inboxController.sort = "desc";
                  widget.inboxController.getTickets(widget.inboxController.sort,
                      widget.inboxController.resolved);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void showFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return FilterModal();
        });
  }
}
