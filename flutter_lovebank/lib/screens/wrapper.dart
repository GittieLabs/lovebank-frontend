import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/screens/invitation/invite_page.dart';
import 'package:flutterapp/screens/home/home_with_notification.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  static var defaultTheme = ThemeData(
    primaryColor: Color(0xffce00e8),
    accentColor: Color(0xfff68dc7),
    backgroundColor: Color(0xfff2f2f2),
    cardColor: Colors.grey[300],
    fontFamily: 'LiberationSans',
  );
  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xffce00e8),
    backgroundColor: Color(0xff303030),
    cardColor: Colors.grey[600],
    fontFamily: 'LiberationSans',
  );
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseUser>(
        converter: (store) => store.state.auth,
        builder: (context, user) {
          if (user == null) {
            return ThreePageIntro();
          } else {
            return StoreConnector<AppState, User>(
                onInit: (store) => store.dispatch(ListenToUserAction(user.uid)),
                onDispose: (store) =>
                    store.dispatch(DontListenToUserAction(user.uid)),
                converter: (store) => store.state.user,
                builder: (context, userData) {
                  if (userData == null) {
                    return Container();
                  } else if (userData.partnerId == "") {
                    return InvitePartnerPage();
                  } else {
                    return StoreConnector<AppState, User>(
                        onInit: (store) => store.dispatch(
                            ListenToPartnerAction(userData.partnerId)),
                        onDispose: (store) => store.dispatch(
                            DontListenToPartnerAction(userData.partnerId)),
                        converter: (store) => store.state.partner,
                        builder: (context, partnerData) {
                          if (partnerData == null) {
                            return Container();
                          } else {
                            return StoreConnector<AppState, User>(
                              converter: (store) => store.state.user,
                              builder: (context, user) {
                                return Theme(
                                  data: (user.darkMode ?? false)
                                      ? darkTheme
                                      : defaultTheme,
                                  child: CompleteHome(),
                                );
                              },
                            );
                          }
                        });
                  }
                });
          }
        });
  }
}
