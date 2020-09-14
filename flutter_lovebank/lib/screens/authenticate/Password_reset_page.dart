import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/screens/components/square_button.dart';
import 'package:flutterapp/services/password_reset_service.dart';

class PasswordReset extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _passwordFormKey = GlobalKey<FormState>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget passwordField = Form(
        key: _passwordFormKey,
        child: Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Column(children: <Widget>[
              Text("Enter your email \n to retrieve your password",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  )),
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
//                      if (value.isEmpty) {
//                        return 'Please enter an email address';
//                      }
//                      return null;
                    }),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SquareButton(
                            text: 'Reset Your Password',
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                            })
                      ),
            ])));

    return MaterialApp(
        home: Scaffold(
          body: Container(
              height: screenHeight,
              width: screenWidth,
              child: Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Spacer(),
                    passwordField,
                    Spacer()
                  ]
              )
          )
        )
        );
  }
}

