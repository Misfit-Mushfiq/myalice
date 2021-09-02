import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/projectsModels/data_source.dart';
import 'package:myalice/screens/inboxScreen/customWidgets/inboxModals/filterModal.dart';

class MainModal extends StatefulWidget {
  InboxController inboxController;
  List<ChannelDataSource?> selectedAnimals;
  bool pendingSelected;
  bool resolvedSelected;
  bool sortNew;
  final Function(bool pendingSelected, bool resolvedSelected, bool sortNew)
      onChanged;
  MainModal(
      {Key? key,
      required this.inboxController,
      required this.pendingSelected,
      required this.resolvedSelected,
      required this.sortNew,
      required this.onChanged,required this.selectedAnimals})
      : super(key: key);

  @override
  _MainModalState createState() => _MainModalState();
}

class _MainModalState extends State<MainModal> {
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
                widget.pendingSelected
                    ? " Resolved Tickets"
                    : " Pending Tickets",
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                widget.pendingSelected
                    ? Icons.check_circle_outline
                    : Icons.lock_clock,
                color: Colors.black,
                size: 25,
              ),
              minLeadingWidth: 0.0,
              contentPadding: EdgeInsets.only(left: 10.0),
              onTap: () {
                setState(() {
                  widget.pendingSelected = !widget.pendingSelected;
                  widget.resolvedSelected = !widget.resolvedSelected;
                  widget.inboxController.isticketsDataAvailable.value = false;
                  widget.resolvedSelected
                      ? widget.inboxController.resolved = 1
                      : widget.inboxController.resolved = 0;
                  widget.inboxController.getTickets(widget.inboxController.sort,
                      widget.inboxController.resolved, "");
                });

                widget.onChanged(widget.pendingSelected,
                    widget.resolvedSelected, widget.sortNew);

                Get.back();
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
                showFilterModal(context, widget.selectedAnimals);
              },
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
                contentPadding: EdgeInsets.only(left: 10.0),
                title: widget.sortNew
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
                  setState(() {
                    widget.sortNew = !widget.sortNew;
                    widget.inboxController.isticketsDataAvailable.value = false;
                    widget.sortNew
                        ? widget.inboxController.sort = "asc"
                        : widget.inboxController.sort = "desc";
                    widget.inboxController.getTickets(
                        widget.inboxController.sort,
                        widget.inboxController.resolved,
                        "");
                  });
                  widget.onChanged(widget.pendingSelected,
                      widget.resolvedSelected, widget.sortNew);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }

  void showFilterModal(BuildContext context, List<ChannelDataSource?> selectedAnimals) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return FilterModal(
              selectedAnimals: selectedAnimals);
        });
  }
}
