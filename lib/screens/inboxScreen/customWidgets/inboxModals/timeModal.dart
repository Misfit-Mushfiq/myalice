import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeModal extends StatefulWidget {
  TimeModal({Key? key}) : super(key: key);

  @override
  _TimeModalState createState() => _TimeModalState();
}

class _TimeModalState extends State<TimeModal> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter state) {
      return Wrap(children: [
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 5,
                ),
                Text("Time"),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date"),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat("dd-MM-yyyy").format(_startDate)),
                            Icon(Icons.calendar_today, color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _selectStartDate(context, state);
                    },
                  ),
                  Text("End Date"),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat("dd-MM-yyyy").format(_endDate)),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _selectEndDate(context, state);
                    },
                  )
                ],
              ),
            )
          ],
        ))
      ]);
    });
  }

  _selectStartDate(BuildContext context, StateSetter state) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialStartDatePicker(context, state);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoStartDatePicker(context, state);
    }
  }

  _selectEndDate(BuildContext context, StateSetter state) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialEndDatePicker(context, state);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoEndDatePicker(context, state);
    }
  }

  /// This builds material date picker in Android
  buildMaterialStartDatePicker(BuildContext context, StateSetter state) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != _startDate)
      state(() {
        _startDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoStartDatePicker(BuildContext context, StateSetter state) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != _startDate)
                  state(() {
                    _endDate = picked;
                  });
              },
              initialDateTime: _startDate,
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
  }

  buildMaterialEndDatePicker(BuildContext context, StateSetter state) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != _endDate)
      state(() {
        _endDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoEndDatePicker(BuildContext context, StateSetter state) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != _endDate)
                  state(() {
                    _endDate = picked;
                  });
              },
              initialDateTime: _endDate,
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
  }
}
