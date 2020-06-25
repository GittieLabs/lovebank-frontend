import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/components/square_button.dart';
import 'package:flutterapp/services/invitationHandler.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutterapp/screens/components/wide_button.dart';
import 'package:provider/provider.dart';

class InvitePartnerPage extends StatefulWidget {
  @override
  _InvitePartnerState createState() => _InvitePartnerState();
}

class _InvitePartnerState extends State<InvitePartnerPage> {
  final _mobileFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final bool inviteSent = true;

  @override
  Widget build(BuildContext context) {
    final partnerMobileField = Form(
        key: _mobileFormKey,
        child: Column(
            children: <Widget>[
              Container(
                height: 44,
                width: 305,
                color: Color.fromRGBO(216, 216, 216, 0.4),
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Mobile',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a mobile number';
                      }
                      return null;
                    }
                ),
              ),
              SquareButton(
                  text: 'Invite',
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    _mobileFormKey.currentState.validate();
                  }
              )
            ]
        )
    );


    final inviteCodeField = Form(
        key: _codeFormKey,
        child: Column(
            children: <Widget>[
              Container (
                height: 44,
                width: 305,
                color: Color.fromRGBO(216, 216, 216, 0.4),
                child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Invitation code',
                ),
                    validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a valid code.';
                    }
                    return null;
                  }
              )
              ),
              SquareButton(
                  text: 'Connect',
                  onPressed: () {
                    // Connect to partner by providing invite code
                    _codeFormKey.currentState.validate();

               }
              )
            ]
        )
    );

    Widget forms = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (inviteSent) ? partnerMobileField : Container(),
          inviteCodeField
        ]
    );


    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hi',
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
                  FlatButton(
                    onPressed: (){},
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        color: Colors.lightBlueAccent
                      ),
                    )
                  ),
                  Text( (inviteSent) ? 'Let\'s connect you to your significant other.' :
                  'Your invitation has been sent',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                      )),
                  (inviteSent) ? forms : Container(),
              ]
            )
        )
    )
    );
  }
}
