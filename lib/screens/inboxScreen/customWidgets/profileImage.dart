import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/utils/routes.dart';
class ProfileImage extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.userDataAvailable
          ? GestureDetector(
              child: new Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new CachedNetworkImageProvider(
                        controller.user.dataSource!.avatar!),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(USER_PROFILE_PAGE, arguments: controller.user);
              },
            )
          : CircularProgressIndicator();
    });
  }
}
