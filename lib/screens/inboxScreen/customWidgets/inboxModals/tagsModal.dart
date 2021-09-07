import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/models/tags/data_source.dart';
import 'package:myalice/models/tags/tags.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/shared_pref.dart';

class TagsModal extends StatefulWidget {
  Tags tags;
  final Function(List<TagsDataSource>? tags) onSaved;
  TagsModal({Key? key, required this.tags, required this.onSaved})
      : super(key: key);

  @override
  _TagsModalState createState() => _TagsModalState();
}

class _TagsModalState extends State<TagsModal> {
  bool assignedAgents = true;
  List<TagsDataSource>? _tags = [];
  List<TagsDataSource> _selectedTags = [];
  SharedPref _sharedPref = SharedPref();
  @override
  void initState() {
    _tags = widget.tags.dataSource;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.tags.dataSource!.map((e) => e.name);
    return Wrap(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  Expanded(child: Text("Tags")),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Reset",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectedTags.clear();
                        _sharedPref.remove("selectedTags");
                        Get.back();
                      }),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AliceColors.ALICE_GREEN),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        widget.onSaved(_selectedTags);
                        _sharedPref.saveString("selectedTags",
                            TagsDataSource.encode(_selectedTags));
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<TagsDataSource>(
                    mode: Mode.BOTTOM_SHEET,
                    items: _tags,
                    hint: "Search for tags",
                    onChanged: (value) {
                      setState(() {
                        _selectedTags.add(value!);
                      });
                    },
                    searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            hintText: "Search for tags",
                            contentPadding: EdgeInsets.only(left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ))),
                    dropdownSearchTextAlign: TextAlign.start,
                    showSelectedItem: false,
                    popupItemBuilder:
                        (context, TagsDataSource? tag, bool selected) {
                      return Container(
                        child: ListTile(
                          title: Text(tag!.name!),
                          trailing: selected ? Icon(Icons.check) : null,
                        ),
                      );
                    },
                    emptyBuilder: (context, String? text) {
                      return Scaffold(
                        body: Container(
                          child: Center(child: Text("No data found")),
                        ),
                      );
                    },
                    dropdownBuilder: (BuildContext context,
                        TagsDataSource? item, String itemDesignation) {
                      return Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Search for tags",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      );
                    },
                    dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    showSearchBox: true),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _selectedTags.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AliceColors.ALICE_SELECTED_CHANNEL),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(_selectedTags.elementAt(index).name!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 12)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.close,
                                        size: 10, color: Colors.green)
                                  ]),
                              onTap: () {
                                setState(() {
                                  _selectedTags.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0.5,
                        mainAxisExtent: 25.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 3),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
