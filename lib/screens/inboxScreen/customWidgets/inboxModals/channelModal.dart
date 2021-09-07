import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/models/responseModels/channels/channels.dart';
import 'package:myalice/models/responseModels/channels/data_source.dart';

import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/platform_icon.dart';
import 'package:myalice/utils/shared_pref.dart';

class ChannelModal extends StatefulWidget {
  //final List<ChannelDataSource?> selectedChannels;
  Channels channels;
  final Function(List<ChannelDataSource?>) onsaved;
  ChannelModal({Key? key, required this.onsaved, required this.channels})
      : super(key: key);

  @override
  _ChannelModalState createState() => _ChannelModalState();
}

class _ChannelModalState extends State<ChannelModal> {
  List<ChannelDataSource> _selectedChannels = [];
  int _index = 0;
  SharedPref _pref = SharedPref();
  @override
  void initState() {
    getSelectedChannels();
    super.initState();
  }

  getSelectedChannels() async {
    _selectedChannels =
        ChannelDataSource.decode(await _pref.readString("selectedChannels"));
  }

  @override
  Widget build(BuildContext context) {
    final _items = widget.channels.dataSource!
        .map((channel) =>
            MultiSelectItem<ChannelDataSource>(channel, channel.title!))
        .toList()
        .obs;
    return StatefulBuilder(builder: (context, StateSetter state) {
      return Column(
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
                child: Text("Channels"),
              ),
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
                    state(() {
                      _selectedChannels.clear();
                      _pref.remove("selectedChannels");
                    });
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    widget.onsaved(_selectedChannels);
                    _pref.saveString("selectedChannels",
                        ChannelDataSource.encode(_selectedChannels));
                  }),
            ],
          ),
          Wrap(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, top: 10.0),
                  child: MultiSelectChipField(
                    items: _items,
                    initialValue: _selectedChannels,
                    showHeader: false,
                    scroll: false,
                    selectedChipColor: AliceColors.ALICE_SELECTED_CHANNEL,
                    chipShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    decoration: BoxDecoration(),
                    /* itemBuilder: (item, state) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _channelSelected = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        color: _channelSelected
                                            ? AliceColors.ALICE_SELECTED_CHANNEL
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            size: 15,
                                          ),
                                          Text(
                                            " " + item.label,
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                               */
                    onTap: (List<ChannelDataSource> values) {
                      _selectedChannels = values;
                    },
                    icon: Icon(
                      platformIcon(
                          widget.channels.dataSource!.elementAt(2).type!),
                      color: platformColor(
                          widget.channels.dataSource!.elementAt(2).type!),
                      size: 5,
                    ),
                  )),
            ],
          )
        ],
      );
    });
  }
}
