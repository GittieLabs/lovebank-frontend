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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:AppBar(
        title: Text('LoveBank'),
        backgroundColor: Theme.of(context).backgroundColor,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 50.0,
          ),
        onPressed: () {},
        backgroundColor: Theme.of(context).backgroundColor,
      ),

    );
  }
  // should this be a class?
  Widget circleImage = CircleAvatar(
    radius: 53.0,
    backgroundColor: Color(0xff9e00ff),
    child: CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/home/Ellipse_2.png'),
    ),
  );
}
