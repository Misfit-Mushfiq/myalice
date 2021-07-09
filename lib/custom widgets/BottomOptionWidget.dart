import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:myalice/utils/choices.dart' as choices;

class BottomOptionWidget extends StatefulWidget {
  @override
  _BottomOptionWidgetState createState() => _BottomOptionWidgetState();
}

class _BottomOptionWidgetState extends State<BottomOptionWidget> {
  String _os = 'win';
  String _hero = 'iro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'OS',
          choiceItems: choices.os,
          onChange: (selected) => setState(() => _os = selected.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/xsGxhtAsfSA/100x100',
                ),
              ),
            );
          }, value: _os,
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Super Hero',
          choiceItems: choices.heroes,
          modalType: S2ModalType.bottomSheet,
          onChange: (selected) => setState(() => _hero = selected.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/8I-ht65iRww/100x100',
                ),
              ),
            );
          }, value: _hero,
        ),
        const SizedBox(height: 7),
      ],
    ),
    );
  }
}
