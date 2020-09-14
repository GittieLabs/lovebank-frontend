import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/screens/components/square_button.dart';
import 'package:flutterapp/services/password_reset_service.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordResetPage> {

  final _passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget passwordField = Form(
        key: _passwordFormKey,
        child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.45, bottom: 25.0),
            child: Column(children: <Widget>[
              Container(
                width: 305,
                color: Color.fromRGBO(216, 216, 216, 0.4),
                child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.only(left: 10),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    }),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SquareButton(
                            text: 'Reset Your Password',
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              if (_passwordFormKey.currentState.validate()){

                              }
                            })
                      )
            ])));

    return MaterialApp(
        home: Scaffold(
          body: Center (
//                height: screenHeight,
//                width: screenWidth,
                child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      passwordField,
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: FlatButton(
                          child: Text('Back',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                      )
                    ]
                )
            )
          )
    );
  }

}

