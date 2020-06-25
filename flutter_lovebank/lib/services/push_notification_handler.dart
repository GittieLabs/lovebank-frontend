import "dart:io" show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _fcm.requestNotificationPermissions(IosNotificationSettings());
    _saveDeviceToken(); // save User ID and device token for individualized notification

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

      onBackgroundMessage: myBackgroundMessageHandler,

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

    _saveDeviceToken() async {
    // Get the current user
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    print(uid);
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('user_collection')
          .document(uid)
          .collection('device')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'platform': Platform.operatingSystem
      });
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
