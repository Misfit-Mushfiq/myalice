import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/chatApiController.dart';
import 'package:myalice/models/responseModels/chatResponse.dart';
import 'package:myalice/utils/db.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherService extends ChatApiController {
  PusherEvent? lastEvent;
  String? lastConnectionState;
  Channel? channel;
  PusherClient? pusher;
  ChatDataBase _chatDataBase = ChatDataBase();

  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Future<void> connectPusher(String channelName, String eventName) async {
    try {
      var options = PusherOptions(cluster: "ap1");
      pusher = PusherClient('199beaccd57c0306a7e7', options,
          enableLogging: true, autoConnect: false);
      pusher!.connect();
      pusher!.onConnectionStateChange((state) {
        print(state.currentState);
      });
      channel = pusher!.subscribe(channelName);
      channel!.bind(eventName, (event) async {
        await _chatDataBase.getChats().then((value) {
          Map<String, dynamic> text = jsonDecode(event.data);
          Get.find<ChatApiController>()
              .chatResponse
              .add(DataSource(text: text['data']['text'],source: text['source'],type: text['type']));
          chatResponse.refresh();
        });
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
