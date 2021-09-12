import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/cannedResponse/canned_response.dart';
import 'package:myalice/models/responseModels/cannedResponse/data_source.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/colors.dart';

class AutoCompleteExample extends StatefulWidget {
  final Function(bool) onAttachmentTap;
  final Function(bool) onTextTap;
  final CannedResponse cannedResponse;

  AutoCompleteExample(
      {Key? key,
      required this.onAttachmentTap,
      required this.onTextTap,
      required this.cannedResponse})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _AutoCompleteExampleState();
}

class _AutoCompleteExampleState extends State<AutoCompleteExample> {
  bool _visiblity = false;
  List<CannedDataSource> cannedResponse = [];

  @override
  void initState() {
    cannedResponse = widget.cannedResponse.dataSource!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Autocomplete<CannedDataSource>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return cannedResponse
              .where((CannedDataSource cannedResponse) =>
                  ("#" + cannedResponse.title!)
                      .toLowerCase()
                      .startsWith(textEditingValue.text.toLowerCase()))
              .toList();
        },
        displayStringForOption: (CannedDataSource option) => option.text!,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return Container(
            padding: EdgeInsets.all(0),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      setState(() {
                        _visiblity = !_visiblity;
                        widget.onAttachmentTap(_visiblity);
                      });
                      fieldFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.add,
                      color: AliceColors.ALICE_GREEN,
                      size: 20,
                    )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    focusNode: fieldFocusNode,
                    onChanged: (String value) {
                      if (value.toLowerCase().startsWith("#")) {
                        widget.onTextTap(true);
                      } else {
                        widget.onTextTap(false);
                      }
                    },
                    controller: fieldTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(5),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    fieldFocusNode.unfocus();
                    //await pusherService.pusherTrigger('test-event');
                    //animateToScreenEnd();

                    Get.find<ChatApiController>()
                        .chatResponse
                        .add(DataSource.fromJson({
                          "text": fieldTextEditingController.text,
                          "source": "admin",
                          "sub_type": "",
                          "type": ""
                        }));
                    /* Get.find<ChatApiController>().sendChats(
                        _ticketId.toString(),fieldTextEditingController.text, ""); */
                    fieldTextEditingController.text = "";
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.send,
                    color: AliceColors.ALICE_GREEN,
                    size: 20,
                  ),
                ),
              ],
            ),
          );
        },
        onSelected: (CannedDataSource selection) {
          print('Selected: ${selection.title!}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<CannedDataSource> onSelected,
            Iterable<CannedDataSource> options) {
          return Align(
            alignment: Alignment.topCenter,
            child: Material(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CannedDataSource option = options.elementAt(index);
              
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                          widget.onTextTap(false);
                        },
                        child: ListTile(
                          title: Text("#" + option.title!,
                              style: const TextStyle(color: Colors.black)),
                          trailing: Text(option.text!,
                              style: const TextStyle(color: Colors.grey)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
