import 'package:flutter/material.dart';
// import 'package:flutter/src/material/icons.dart';
import 'package:flutterapp/services/userAuthentication.dart';

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


class ChallengePage extends StatelessWidget {
  final AuthService _auth = AuthService();
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