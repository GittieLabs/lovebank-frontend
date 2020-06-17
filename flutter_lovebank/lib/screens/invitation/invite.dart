import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutterapp/screens/components/wide_button.dart';
import 'package:provider/provider.dart';

class InvitePartner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final AuthService _auth = AuthService();

    return  MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Hi ${user.displayName}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30,
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/invite/person.png'),
                    backgroundColor: Colors.white,
                  ),
                  Text('Let\'s connect you to your significant other.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    )),
                  Container(
                      child: FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text('logout'),
                        onPressed: () async{
                          await _auth.signOut();
                        },
                      )

                  )

                ],

              ),
            )
        )
    );
  }
}
