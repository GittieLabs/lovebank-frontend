import "dart:io" show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _fcm.requestNotificationPermissions(IosNotificationSettings());

    _fcm.configure(
      
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
                showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // different logic for iOS - message composition varies based on platform
            
                content: ListTile(
                  title: Text(message["notification"]["title"]),
                  subtitle: Text(message['notification']["body"]),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.amber,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );


    if (Platform.isIOS) {
      // iOS-specific code
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // different logic for iOS - message composition varies based on platform
            
                content: ListTile(
                  title: Text(message["aps"]["alert"]["title"]),
                  subtitle: Text(message["aps"]["alert"]["body"]),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.amber,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      },
      );

    }
  }  
    
  @override
  Widget build(BuildContext context) {
    // _handleMessages(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('LoveBank Notifications'),
      ),
      body: Text("Notification Layer"),
    );
  }
}