import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myalice/controllers/pusherController.dart';
import 'package:myalice/screens/first.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      title: title,
      home: First(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  String _platformVersion = 'Unknown';

  PusherService pusherService = PusherService();

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    pusherService = PusherService();
    pusherService.connectPusher('ios-channel', 'ios-event');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: pusherService.eventStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      child: Text(snapshot.data.toString()),
                    );
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    pusherService.pusherTrigger();
                  },
                  child: Text("Send"))
            ],
          ),
        ),
      ),
    );
  }
}
