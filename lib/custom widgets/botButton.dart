import 'package:flutter/cupertino.dart';
import 'package:myalice/utils/colors.dart';

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch({required this.switchValue, required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  late bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSwitch(
          activeColor: AliceColors.ALICE_GREEN,
          value: _switchValue,
          onChanged: (bool value) {
            setState(() {
              _switchValue = value;
              widget.valueChanged(value);
            });
          }),
    );
  }
}
