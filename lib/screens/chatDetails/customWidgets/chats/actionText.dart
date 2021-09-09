import 'package:flutter/material.dart';
import 'package:myalice/utils/colors.dart';

class ActionText extends StatefulWidget {
  final text;
  ActionText({Key? key, required this.text}) : super(key: key);

  @override
  _ActionTextState createState() => _ActionTextState();
}

class _ActionTextState extends State<ActionText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: AliceColors.ALICE_GREY, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          Expanded(
            child: Divider(
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
