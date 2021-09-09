import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/utils/colors.dart';

class InboxTagsModal extends StatefulWidget {
  final items;
  InboxTagsModal({Key? key, required this.items}) : super(key: key);

  @override
  _InboxTagsModalState createState() => _InboxTagsModalState();
}

class _InboxTagsModalState extends State<InboxTagsModal> {
  List<Object?> _selectedTags = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
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
            Expanded(
              child: Text("Used Tags"),
            ),
            InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add New Tags",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    // _animals.add(Animal(id: 4, name: "Lionss"));
                  });
                })
          ],
        ),
        Wrap(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: MultiSelectChipField(
                      items: widget.items,
                      showHeader: false,
                      scroll: false,
                      initialValue: _selectedTags,
                      headerColor: Colors.white,
                      chipShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      decoration: BoxDecoration(),
                      selectedChipColor: AliceColors.ALICE_GREEN,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      onTap: (values) {
                        _selectedTags = values;
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  /* _selectedChannels2.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "None selected",
                                        style: TextStyle(color: Colors.black54),
                                      ))
                                  : MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedChannels2.remove(value);
                                    });
                                  },
                                ), */
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
