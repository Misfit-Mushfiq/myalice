import 'package:flutter/material.dart';
import 'package:myalice/utils/colors.dart';

class ActionText extends StatefulWidget {
  final text;
  final type;
  ActionText({Key? key, required this.text, required this.type})
      : super(key: key);

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
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                decoration: widget.type == "action"? BoxDecoration(
                  color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(20)):BoxDecoration(
                    color:
                         Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
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
