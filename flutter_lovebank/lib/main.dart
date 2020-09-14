import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/redux/app_state.dart';
import 'package:flutterapp/redux/middleware.dart';
import 'package:flutterapp/redux/reducers.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:flutter/rendering.dart'; //used for debugPaintSizeEnabled
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux/redux.dart';

void main() {
  //debugPaintSizeEnabled = true; //uncomment this line and restart to better see the sizes of elements drawn onscreen
  runApp(new LoveApp());
}

class LoveApp extends StatelessWidget {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Firestore firestore = Firestore.instance;

  static final allEpics = combineEpics<AppState>([
    registerEpic,
    loginEpic,
    logoutEpic,
    userChangesEpic,
    partnerChangesEpic,
    inviteChangesEpic
  ]);

  final store = new Store<AppState>(reducer,
      initialState: AppState(), middleware: [EpicMiddleware(LoveApp.allEpics)]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "LoveBank",
        theme: ThemeData(
          primaryColor: Color(0xffce00e8),
          accentColor: Color(0xfff68dc7),
          backgroundColor: Color(0xfff2f2f2),
          fontFamily: 'LiberationSans',
        ),
        home: Wrapper(), //wrapper class deals with the login status of the user
      ),
    );
  }
}
