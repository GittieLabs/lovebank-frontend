import 'package:flutter/material.dart';
// import 'package:flutter/src/material/icons.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

/*
Basic Home Screen Layout created to test user sign in
*/

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[100],
      appBar:AppBar(
        title: Text('LoveBank'),
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
    );
  }
}


class SettingsPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar:AppBar(
        title: Text('Account & Settings'),
        backgroundColor: Colors.yellow[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
    );
  }
}

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}


class _ChallengePageState extends State<ChallengePage> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    get_update_notification();
  }

    void get_update_notification() async{
    // Get the current user
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    final FirebaseMessaging _fcm = FirebaseMessaging();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    final response = await http.get('http://lovebank.herokuapp.com/update/$uid/$fcmToken');
    
    if (response.statusCode == 200) {
      print ("Update Message Sent Successful");
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orange[100],
      appBar:AppBar(
        title: Text('Challenges'),
        backgroundColor: Colors.orange[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
    );
  }
}