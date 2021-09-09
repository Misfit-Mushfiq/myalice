import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
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
          Get.find<ChatApiController>().chatResponse.add(DataSource(
              text: text['data']['text'],
              source: text['source'],
              type: text['type']));
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
}

/* void unSubscribePusher(String channelName) {
  Pusher.unsubscribe(channelName);
} */
