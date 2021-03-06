import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/models/local_invite.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/screens/components/square_button.dart';
import 'package:flutterapp/services/image_storage_service.dart';
import 'package:flutterapp/services/invitation_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class InvitePartnerPage extends StatefulWidget {
  @override
  _InvitePartnerState createState() => _InvitePartnerState();
}

class _InvitePartnerState extends State<InvitePartnerPage> {
  // Testing purpose: set true to show revoke invite page,
  //                  set false to show invitation page
  final _mobileFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

  String mobile;
  String userID;
  String inviteCode;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color buttonColor = Theme.of(context).primaryColor;

    bool smallScreen = screenHeight < 601;

    // Photo edit button
    Widget editButton = FlatButton(
        onPressed: () async {
          final action = CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text("Camera"),
                isDefaultAction: true,
                onPressed: () async {
//              profileImage = await enableCamera();
                  Navigator.pop(context);
                },
              ),
              StoreConnector<AppState, FirebaseUser>(
                  converter: (store) => store.state.auth,
                  builder: (context, user) {
                    return CupertinoActionSheetAction(
                      child: Text("Photo Gallery"),
                      isDefaultAction: true,
                      onPressed: () async {
                        File image = await openGallery();
                        if (image != null) {
                          String imageURL = await uploadFile(image, user.uid);
                          var idToken = await user.getIdToken();
                          updateProfilePic(user.uid, imageURL, idToken.token);
                        }
                        Navigator.pop(context);
                      },
                    );
                  })
            ],
          );
          showCupertinoModalPopup(
              context: context, builder: (context) => action);
        },
        child: Text(
          "Edit",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              color: Colors.lightBlueAccent),
        ));

    // Form for inputting partner mobile, including text field and submit button
    final partnerMobileField = Form(
        key: _mobileFormKey,
        child: Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Column(children: <Widget>[
              Container(
                width: 305,
                color: Color.fromRGBO(216, 216, 216, 0.4),
                child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                      contentPadding: const EdgeInsets.only(left: 10),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: buttonColor)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a mobile number';
                      }
                      mobile = value;
                      return null;
                    }),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: StoreConnector<AppState, FirebaseUser>(
                      converter: (store) => store.state.auth,
                      builder: (context, user) {
                        return SquareButton(
                            text: 'Invite',
                            color: buttonColor,
                            onPressed: () async {
                              if (_mobileFormKey.currentState.validate()) {
                                var idToken = await user.getIdToken();
                                inviteBtnClicked(
                                    user.uid, mobile, idToken.token);
                              }
                            });
                      })),
            ])));

    // Form for inputting invite code, including text field and submit button
    final inviteCodeField = Center(
        child: Form(
            key: _codeFormKey,
            child: Column(children: <Widget>[
              Container(
                  width: 305,
                  color: Color.fromRGBO(216, 216, 216, 0.4),
                  child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Invitation code',
                        contentPadding: const EdgeInsets.only(left: 10),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonColor)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a valid code.';
                        }
                        inviteCode = value;
                        return null;
                      })),
              StoreConnector<AppState, FirebaseUser>(
                  converter: (store) => store.state.auth,
                  builder: (context, user) {
                    return SquareButton(
                        text: 'Connect',
                        color: buttonColor,
                        onPressed: () async {
                          // Connect to partner by providing invite code
                          if (_codeFormKey.currentState.validate()) {
                            var idToken = await user.getIdToken();
                            acceptBtnClicked(
                                user.uid, inviteCode, idToken.token);
                          }
                        });
                  }),
            ])));

    // Contains both partnerMobile form and inviteCode form
    Widget invitationForms = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[partnerMobileField, inviteCodeField]);

    // Invite revoke button
    Widget revokeButton = Center(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: StoreConnector<AppState, FirebaseUser>(
                converter: (store) => store.state.auth,
                builder: (context, user) {
                  return SquareButton(
                      text: 'Revoke Invitation',
                      color: buttonColor,
                      onPressed: () async {
                        var idToken = await user.getIdToken();
                        revokeBtnClicked(user.uid, idToken.token);
                        return InvitePartnerPage();
                      });
                })));

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: StoreConnector<AppState, AppState>(
                        onInit: (store) => store.dispatch(
                            ListenToInviteAction(store.state.user.userId)),
                        onDispose: (store) => store.dispatch(
                            DontListenToInviteAction(store.state.user.userId)),
                        converter: (store) => (store.state),
                        builder: (context, state) {
                          User localUser = state.user;
                          bool inviteSent = state.invite != null;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.1),
                                  child: Text(
                                    'Hi' + " " + localUser.displayName + "!",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: (smallScreen) ? 20 : 30,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 20),
                                  child: CircleAvatar(
                                    radius: smallScreen ? 30 : 60,
                                    backgroundImage: localUser.profilePic ==
                                                null ||
                                            localUser.profilePic == ""
                                        ? AssetImage(
                                            'assets/images/invite/person.png')
                                        : NetworkImage(localUser.profilePic),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                editButton,
                                Text(
                                    (!inviteSent)
                                        ? 'Let\'s connect you to your significant other.'
                                        : 'Your invitation has been sent.',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                    )),
                                (!inviteSent) ? Spacer() : Container(),
                                (!inviteSent) ? invitationForms : revokeButton,
                                StoreConnector<AppState, VoidCallback>(
                                    converter: (store) => () {
                                          store.dispatch(LogoutAction());
                                        },
                                    builder: (context, callback) {
                                      return FlatButton.icon(
                                          icon: Icon(Icons.person),
                                          label: Text('logout'),
                                          onPressed: () {
                                            callback();
                                          });
                                    }),
                                (!inviteSent) ? Spacer() : Container(),
                              ]);
                        })))));
  }
}
