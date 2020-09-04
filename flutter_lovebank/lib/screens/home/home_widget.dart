import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/models/local_user.dart';
import 'package:flutterapp/redux/actions.dart';
import 'package:flutterapp/redux/app_state.dart';
// import 'package:flutter/src/material/icons.dart';
import 'package:flutterapp/services/user_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/main.dart';
import 'package:flutterapp/services/invitation_handler.dart';

/*
Basic Home Screen Layout created to test user sign in
*/
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userMostRecentTask = 'take out the trash';
  String partnerMostRecentTask = 'buy take-out';
  int userRecentTaskPoints = 50;
  int partnerRecentTaskPoints = 80;
  String userRecentTaskTime = '30 mins ';
  String partnerRecentTaskTime = '1 day ';
  String taskSuggestion1 = 'Walk the dog everyday this week';
  String taskSuggestion2 = 'Walk the dog everyday this week';
  String taskSuggestion3 = 'Walk the dog everyday this week';
  String taskSuggestion4 = 'Walk the dog everyday this week';
  @override
  Widget build(BuildContext context) {
    Widget userImageNameBalance = StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, userData) {
          return Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    userData.profilePic == null || userData.profilePic == ""
                        ? AssetImage('assets/images/invite/person.png')
                        : NetworkImage(userData.profilePic),
                backgroundColor: Colors.white,
              ),
              Text(userData.displayName),
              Row(
                children: <Widget>[
                  Text('balance '),
                  Text(
                    userData.balance.toString(),
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 40),
                  ),
                ],
              ),
            ],
          );
        });
    Widget partnerImageNameBalance = StoreConnector<AppState, User>(
        converter: (store) => store.state.partner,
        builder: (context, partnerData) {
          return Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: partnerData.profilePic == null ||
                        partnerData.profilePic == ""
                    ? AssetImage('assets/images/invite/person.png')
                    : NetworkImage(partnerData.profilePic),
                backgroundColor: Colors.white,
              ),
              Text(partnerData.displayName),
              Row(
                children: <Widget>[
                  Text('balance '),
                  Text(
                    partnerData.balance.toString(),
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 40),
                  ),
                ],
              ),
            ],
          );
        });
    Widget userAndPartnerProfilePictures = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          userImageNameBalance,
          partnerImageNameBalance,
        ],
      ),
    );
    Widget recentTasks = Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        // height: 200.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(14.0),
              topRight: const Radius.circular(14.0),
              bottomLeft: const Radius.circular(14.0),
              bottomRight: const Radius.circular(14.0)),
        ),
        child: StoreConnector<AppState, User>(
            converter: (store) => store.state.partner,
            builder: (context, partnerData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Tasks',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    child: Text(
                      'you' +
                          ': asked ' +
                          partnerData.displayName +
                          ' to ' +
                          userMostRecentTask +
                          ' for ' +
                          userRecentTaskPoints.toString() +
                          ' points',
                      style: TextStyle(
                        fontFamily: 'Actor',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    child: Text(
                      userRecentTaskTime + 'ago',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    child: Text(
                      partnerData.displayName +
                          ': asked ' +
                          'you' +
                          ' to ' +
                          partnerMostRecentTask +
                          ' for ' +
                          partnerRecentTaskPoints.toString() +
                          ' points ',
                      style: TextStyle(
                        fontFamily: 'Actor',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    child: Text(
                      partnerRecentTaskTime + 'ago',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              );
            }));
    Widget taskSuggestions = Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Task Suggestions',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                taskSuggestion1,
                style: TextStyle(
                  color: Color(0xffce00e8),
                  fontFamily: 'Actor',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                taskSuggestion2,
                style: TextStyle(
                  color: Color(0xffce00e8),
                  fontFamily: 'Actor',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                taskSuggestion3,
                style: TextStyle(
                  color: Color(0xffce00e8),
                  fontFamily: 'Actor',
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget homeScreenLayOut = Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          // title: Text('LoveBank'),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          actions: <Widget>[
            StoreConnector<AppState, VoidCallback>(
                converter: (store) => () {
                      store.dispatch(LogoutAction());
                    },
                builder: (context, callback) {
                  return FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('logout'),
                      onPressed: callback);
                })
          ]),
      body: Column(
        children: <Widget>[
          userAndPartnerProfilePictures,
          recentTasks,
          taskSuggestions,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).backgroundColor,
          size: 50.0,
        ),
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    return homeScreenLayOut;
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _auth = AuthService();
  bool all_notifications = true;

  @override
  Widget build(BuildContext context) {
    Widget userImage = StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, userData) {
          return CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage:
                userData.profilePic == null || userData.profilePic == ""
                    ? AssetImage('assets/images/invite/person.png')
                    : NetworkImage(userData.profilePic),
            radius: 60.0,
          );
        });
    Widget settingsOptions = StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, userData) {
          return StoreConnector<AppState, FirebaseUser>(
              converter: (store) => store.state.auth,
              builder: (context, user) {
                return Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        title: Text('Enable All Notifications'),
                        activeColor: Theme.of(context).primaryColor,
                        value: (userData.task_reminder_notifications &&
                            userData.task_acceptance_notifications &&
                            userData.task_completion_notifications &&
                            all_notifications),
                        onChanged: (bool value) async {
                          setState(() {
                            all_notifications = value;
                          });
                          var idToken = await user.getIdToken();
                          var id = user.uid;
                          if (value) {
                            await updateBtnClicked(
                                id, 'all_notifications', value, idToken.token);
                          }
                        },
                      ),
                      SwitchListTile(
                        title: Text('Task Reminder Notifications'),
                        activeColor: Theme.of(context).primaryColor,
                        value: userData.task_reminder_notifications,
                        onChanged: (bool value) async {
                          var idToken = await user.getIdToken();
                          await updateBtnClicked(
                              user.uid,
                              'task_reminder_notifications',
                              !userData.task_reminder_notifications,
                              idToken.token);
                        },
                      ),
                      SwitchListTile(
                        title: Text('Task Acceptance/Rejection Notifications'),
                        activeColor: Theme.of(context).primaryColor,
                        value: userData.task_acceptance_notifications,
                        onChanged: (bool value) async {
                          var idToken = await user.getIdToken();
                          await updateBtnClicked(
                              user.uid,
                              'task_acceptance_notifications',
                              !userData.task_acceptance_notifications,
                              idToken.token);
                        },
                      ),
                      SwitchListTile(
                        title: Text('Task Complete/Incomplete Notifications'),
                        activeColor: Theme.of(context).primaryColor,
                        value: userData.task_completion_notifications,
                        onChanged: (bool value) async {
                          var idToken = await user.getIdToken();
                          await updateBtnClicked(
                              user.uid,
                              'task_completion_notifications',
                              !userData.task_completion_notifications,
                              idToken.token);
                        },
                      ),
                      SwitchListTile(
                        title: Text('Dark Mode'),
                        activeColor: Theme.of(context).primaryColor,
                        value: userData.darkMode,
                        onChanged: (bool value) async {
                          var idToken = await user.getIdToken();
                          await updateBtnClicked(user.uid, 'darkMode',
                              !userData.darkMode, idToken.token);
                        },
                      ),
                    ],
                  ),
                );
              });
        });
    Widget unlinkButtonText = StoreConnector<AppState, User>(
      converter: (store) => store.state.partner,
      builder: (context, partnerData) {
        return Text('Unlink from ${partnerData.displayName}');
      },
    );
    Widget confirmButton = StoreConnector<AppState, FirebaseUser>(
      converter: (store) => store.state.auth,
      builder: (context, user) {
        return FlatButton(
          child: Text('Confirm'),
          onPressed: () async {
            var idToken = await user.getIdToken();
            unlinkBtnClicked(user.uid, idToken.token);
            Navigator.of(context).pop();
          },
        );
      },
    );
    Widget cancelButton = StoreConnector<AppState, User>(
      converter: (store) => store.state.partner,
      builder: (context, partnerData) {
        return FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    Widget unlinkDialog = StoreConnector<AppState, User>(
      converter: (store) => store.state.partner,
      builder: (context, partnerData) {
        return AlertDialog(
          title: Text('Unlinking Accounts'),
          content: Text(
              'Are you sure you want to unlink from ${partnerData.displayName}? \n \nThis action cannot be reversed.'),
          actions: [
            confirmButton,
            cancelButton,
          ],
        );
      },
    );
    Widget unlinkOption = StoreConnector<AppState, FirebaseUser>(
      converter: (store) => store.state.auth,
      builder: (context, user) {
        return Container(
          child: FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: unlinkButtonText,
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return unlinkDialog;
                  });
            },
          ),
        );
      },
    );
    Widget logoutOption = StoreConnector<AppState, VoidCallback>(
      converter: (store) => () {
        store.dispatch(LogoutAction());
      },
      builder: (context, callback) {
        return Container(
          child: RaisedButton(
            onPressed: (callback),
            textColor: Colors.white,
            color: Color(0xffce00e8),
            child: Text('Logout'),
          ),
        );
      },
    );
    Widget settingsLayout = StoreConnector<AppState, User>(
        converter: (store) => store.state.user,
        builder: (context, userData) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userImage,
                  settingsOptions,
                  unlinkOption,
                  logoutOption,
                  Container(
                    width: double.infinity,
                  )
                ],
              ),
            ),
          );
        });
    return settingsLayout;
  }
}

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    get_update_notification();
  }

  void get_update_notification() async {
    // Get the current user
    final FirebaseAuth _auth = LoveApp.firebaseAuth;
    FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    final FirebaseMessaging _fcm = FirebaseMessaging();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    final response =
        await http.get('http://lovebank.herokuapp.com/update/$uid/$fcmToken');

    if (response.statusCode == 200) {
      print("Update Request Sent Successful");
    } else {
      print("Update Request Errored");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:
          AppBar(title: Text('Challenges'), elevation: 0.0, actions: <Widget>[
        StoreConnector<AppState, VoidCallback>(
            converter: (store) => () {
                  store.dispatch(LogoutAction());
                },
            builder: (context, callback) {
              return FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: callback);
            })
      ]),
    );
  }
}
