import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pusher_client/pusher_client.dart';

class PusherService extends ChatApiController {
  PusherEvent? lastEvent;
  String? lastConnectionState;
  Channel? channel;
  PusherClient? pusher;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> connectPusher(String channelName, String eventName) async {
    try {
      var options = PusherOptions(cluster: "ap1");
      pusher = PusherClient('199beaccd57c0306a7e7', options,
          enableLogging: true, autoConnect: false);
      pusher!.connect();
      pusher!.onConnectionStateChange((state) {
        print(state!.currentState);
      });
      channel = pusher!.subscribe(channelName);
      channel!.bind(eventName, (event) async {
        Map<String, dynamic> text = jsonDecode(event!.data!);
        if (text['source'] == "customer") {
          ChatApiController _controller = Get.put(ChatApiController());
             _controller.chatResponse.add(DataSource(
                text: text['data']['text'],
                source: text['source'],
                type: text['data']['type'],
                subType: text['data']['type'] == "attachment"
                    ? text['data']["attachment"]["type"]
                    : "",
                imageUrl: text['data']['type'] == "attachment"
                    ? text['data']["attachment"]["type"] == "image"
                        ? text['data']["attachment"]["urls"][0]
                        : ""
                    : ""));
            const AndroidNotificationDetails androidPlatformChannelSpecifics =
                AndroidNotificationDetails('12345', 'your channel name',
                    'your channel description', //Required for Android 8.0 or after
                    importance: Importance.max,
                    priority: Priority.high);

            const IOSNotificationDetails iOSPlatformChannelSpecifics =
                IOSNotificationDetails(
              presentAlert:
                  true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
              presentBadge:
                  true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
              presentSound:
                  true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
              sound:
                  "", // Specifics the file path to play (only from iOS 10 onwards)
              badgeNumber: 1, // The application's icon badge number
              //attachments: List<IOSNotificationAttachment> != null?// (only from iOS 10 onwards)
              //subtitle: String?, //Secondary description  (only from iOS 10 onwards)
              // threadIdentifier: String? (only from iOS 10 onwards)
            );

            const NotificationDetails platformChannelSpecifics =
                NotificationDetails(android: androidPlatformChannelSpecifics);
            _showNotification(platformChannelSpecifics,text['data']['text']);
          
        }
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  /* pusherTrigger(String eventName) {
    channel!.bind("test-channel", (PusherEvent event) {
      channel!.trigger(eventName, {"name": "Bob"});
      log(event.data);
      _inEventData.add(event.data);
    });
  } */
   Future<void> _showNotification(NotificationDetails platformChannelSpecifics,String text) async {
    await flutterLocalNotificationsPlugin.show(
        1234,
        "A Notification From My Application",
        text,
        platformChannelSpecifics,
        payload: 'data');
  }
}

/* void unSubscribePusher(String channelName) {
  Pusher.unsubscribe(channelName);
} */
