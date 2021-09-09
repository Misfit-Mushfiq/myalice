import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myalice/utils/colors.dart';

class Texts extends StatelessWidget {
  final object;
  final index;
  const Texts({Key? key, required this.object, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 1, top: 10),
      child: Align(
        alignment: (object.chats.elementAt(index)!.source == "customer"
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: object.chats.elementAt(index)!.source == "customer"
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
            color: (object.chats.elementAt(index)!.source == "customer"
                ? AliceColors.CHAT_RECEIVER
                : AliceColors.CHAT_SENDER),
          ),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: object.chats.elementAt(index)!.type == "attachment" &&
                  object.chats.elementAt(index)!.subType == "image"
              ? CachedNetworkImage(
                  imageUrl: object.chats.elementAt(index)!.imageUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : object.chats.elementAt(index)!.type == "action" &&
                      object.chats.elementAt(index)!.source == "admin"
                  ? Container(
                      child: Container(
                          child: Text(
                            object.chats.elementAt(index)!.text!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          decoration: BoxDecoration(
                              color: AliceColors.ALICE_GREEN,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5)))
                  : Text(
                      object.chats.elementAt(index)!.source == "customer"
                          ? object.chats.elementAt(index)!.text!
                          : object.chats.elementAt(index)!.text!,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: (object.chats.elementAt(index)!.source ==
                                  "customer"
                              ? Colors.black
                              : Colors.white)),
                    ),
        ),
      ),
    );
    ;
  }
}
