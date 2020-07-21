import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/screens/invitation/invite_page.dart';
import 'package:flutterapp/screens/home/home_with_notification.dart';
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

    FirebaseUser user = Provider.of<FirebaseUser>(context);

    UserDataService dataService = UserDataService();
    dataService.listenTo(user.uid);
    Stream<User> userDataStream = dataService.userData;

    if (user == null) {
      return ThreePageIntro();
    } else {
      return StreamProvider<User>.value(
          value: userDataStream,
          child: (Provider.of<User>(context) == null)
              ? Container()
              : (Provider.of<User>(context).partnerId == null)
                  ? InvitePartnerPage()
                  : CompleteHome()
      );
    }
  }
}
