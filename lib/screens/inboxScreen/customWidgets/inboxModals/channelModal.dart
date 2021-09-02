import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myalice/screens/chatDetails.dart';
import 'package:myalice/utils/colors.dart';

class ChannelModal extends StatefulWidget {
  final List<Animal?> selectedAnimals;
  final Function(List<Animal?>) onsaved;
  ChannelModal({Key? key, required this.onsaved, required this.selectedAnimals})
      : super(key: key);

  @override
  _ChannelModalState createState() => _ChannelModalState();
}

class _ChannelModalState extends State<ChannelModal> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
  ];

  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

  List<Animal?> _selectedAnimals1 = [];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter state) {
      return Container(
          height: 200,
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
                          _selectedAnimals1.clear();
                          widget.selectedAnimals.clear();
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
                        widget.onsaved(_selectedAnimals1);
                      }),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10.0),
                        child: MultiSelectChipField(
                          items: _items,
                          showHeader: false,
                          selectedChipColor: AliceColors.ALICE_SELECTED_CHANNEL,
                          height: 50,
                          initialValue: widget.selectedAnimals,
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
                          onTap: (List<Animal?> values) {
                            _selectedAnimals1 = values;
                          },
                          icon: Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      /* _selectedAnimals2.isEmpty
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
                                      _selectedAnimals2.remove(value);
                                    });
                                  },
                                ), */
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }
}
