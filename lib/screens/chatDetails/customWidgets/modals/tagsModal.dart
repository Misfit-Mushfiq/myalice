import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/tags/tags.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class InboxTagsModal extends StatefulWidget {
  final List<TagsDataSource> tags;
  final List<TagsDataSource> selectedTags;
  final Function(List<TagsDataSource> selectedTags) onsaved;
  InboxTagsModal(
      {Key? key,
      required this.tags,
      required this.selectedTags,
      required this.onsaved})
      : super(key: key);

  @override
  _InboxTagsModalState createState() => _InboxTagsModalState();
}

class _InboxTagsModalState extends State<InboxTagsModal> {
  SharedPref _pref = SharedPref();
  var _selectedTags = <TagsDataSource>[];
  var _tags;
  @override
  void initState() {
    getTags();
    super.initState();
  }

  getTags() async {
    _selectedTags = widget.selectedTags;
    _tags = widget.tags
        .map((animal) => MultiSelectItem<TagsDataSource>(animal, animal.name!))
        .toList();
    widget.selectedTags.forEach((element) {
      print(element.name);
    });
  }

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
                child: MultiSelectChipField<TagsDataSource>(
              items: _tags,
              showHeader: false,
              scroll: false,
              initialValue: _selectedTags,
              headerColor: Colors.white,
              chipShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              decoration: BoxDecoration(),
              selectedChipColor: AliceColors.ALICE_GREEN,
              searchable: true,
              selectedTextStyle: TextStyle(color: Colors.white),
              onTap: (values) {
                widget.onsaved(values);
                _pref.saveString(
                    "selectedInboxTags", TagsDataSource.encode(values));
                addTag(values);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            )),
          ],
        )
      ],
    ));
  }

  addTag(List<TagsDataSource> values) {
    /* for(int i=0;i<1;i++) {
      Get.find<ChatApiController>()
          .addTicketTags("add", element.name!, element.id!);
    } */
  }
}
