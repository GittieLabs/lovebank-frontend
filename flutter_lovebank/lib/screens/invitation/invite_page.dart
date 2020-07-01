import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  // Testing purpose: set true to show revoke invite page,
  //                  set false to show invitation page
  final bool inviteSent = false;
  final _mobileFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Photo edit button
    Widget editButton = FlatButton(
        onPressed: (){},
        child: Text(
          "Edit",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              color: Colors.lightBlueAccent
          ),
        )
    );

    // Form for inputting partner mobile, including text field and submit button
    final partnerMobileField = Form(
        key: _mobileFormKey,
        child: Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Column(
                children: <Widget>[
                  Container(
                    height: 44,
                    width: 305,
                    color: Color.fromRGBO(216, 216, 216, 0.4),
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Mobile',
                          contentPadding: const EdgeInsets.only(left: 10),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor)
                          ),
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
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        _mobileFormKey.currentState.validate();
                      }
                  )
                ]
            )
        )
    );

    // Form for inputting invite code, including text field and submit button
    final inviteCodeField = Center(
        child: Form(
            key: _codeFormKey,
            child: Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Column(
                    children: <Widget>[
                      Container (
                          height: 44,
                          width: 305,
                          color: Color.fromRGBO(216, 216, 216, 0.4),
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Invitation code',
                                contentPadding: const EdgeInsets.only(left: 10),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor)
                                ),
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
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            // Connect to partner by providing invite code
                            _codeFormKey.currentState.validate();

                          }
                      )
                    ]
                )
            )
        )
    );

    // Contains both partnerMobile form and inviteCode form
    Widget invitationForms =
//        padding: EdgeInsets.only(top:screenHeight * 0.20),
        Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[

         partnerMobileField,
          inviteCodeField
        ]
    );


    // Invite revoke button
    Widget revokeButton = Center(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
            child: SquareButton(
      text: 'Revoke Invitation',
      color: Theme.of(context).primaryColor,
      onPressed: ()=>{},
    )
    )
    );


    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(

              child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Padding(
                       padding: EdgeInsets.only(top: screenHeight * 0.1),
                        child: Text('Hi',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                        ),
                      ),
                     ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/invite/person.png'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    editButton,

                     Text( (!inviteSent) ? 'Let\'s connect you to your significant other.' :
                      'Your invitation has been sent.',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                          )),
                    (!inviteSent) ? Spacer() : Container(),
                    (!inviteSent) ? invitationForms : revokeButton,
                    FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('logout'),
                      onPressed: () async{
                        await _auth.signOut();
                      }, // This logout button is for testing purpose only. 
                    ),
                    (!inviteSent) ? Spacer() : Container(),

                  ]
              ))

        )
    )
    );
  }
}
