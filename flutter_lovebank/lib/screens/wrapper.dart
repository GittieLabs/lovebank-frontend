import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/screens/invitation/invite_page.dart';
import 'package:flutterapp/screens/home/home_with_notification.dart';
import 'package:flutterapp/services/invite_data_service.dart';
import 'package:flutterapp/services/user_data_service.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
                            return CompleteHome();
                          }
                        });
                  }
                });
          }
        });
  }
}
