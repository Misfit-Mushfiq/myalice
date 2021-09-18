import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/utils/routes.dart';

class ProfileImage extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    InboxController _inboxController = Get.put(InboxController());
    return Obx(() {
      return _inboxController.userDataAvailable
          ? GestureDetector(
              child: new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new CachedNetworkImageProvider(
                        _inboxController.user.dataSource!.avatar!),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(USER_PROFILE_PAGE, arguments: [
                  _inboxController.user,
                  _inboxController.projects
                ]);
              },
            )
          : CircularProgressIndicator();
    });
  }
}
