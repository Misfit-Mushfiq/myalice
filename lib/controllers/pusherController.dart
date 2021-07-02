import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherService {
  PusherEvent? lastEvent;
  String? lastConnectionState;
  Channel? channel;
  PusherClient? pusher;

  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Future<void> connectPusher(String channelName, String eventName) async {
    try {
      var options = PusherOptions(cluster: "ap2");
      pusher = PusherClient('48ad6dcfdb864c89354a', options,
          enableLogging: true, autoConnect: false);
      pusher!.connect();
      pusher!.onConnectionStateChange((state) {
        print(state.currentState);
      });
      channel = pusher!.subscribe(channelName);
      channel!.bind(eventName, (event) {
        log(event.data);
        _inEventData.add(event.data);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  pusherTrigger() {
    channel!.bind("pusher:subscription_succeeded", (PusherEvent event) {
      channel!.trigger("my-event", {"name": "Bob"});
      log(event.data);
      _inEventData.add(event.data);
    });
  }
}

/* void unSubscribePusher(String channelName) {
  Pusher.unsubscribe(channelName);
} */
