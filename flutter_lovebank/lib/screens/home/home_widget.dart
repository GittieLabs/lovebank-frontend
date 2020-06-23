import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Model/UserData.dart';
import 'package:flutterapp/screens/intro/three_page_intro.dart';
// import 'package:flutter/src/material/icons.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:flutterapp/screens/components/circular_image.dart';
import 'package:provider/provider.dart';
/*
Basic Home Screen Layout created to test user sign in
*/

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  String partnerID;
  String userImagePath = 'assets/images/home/Ellipse_1.png'; //need to replace this with the url to User's profile pic
  String partnerImagePath = 'assets/images/home/Ellipse_2.png';
  String userName;
  String partnerName;
  int userBalance;
  int partnerBalance;
  String userMostRecentTask = 'take out the trash' ;
  String partnerMostRecentTask = 'buy take-out';
  int userRecentTaskPoints = 50;
  int partnerRecentTaskPoints = 80;
  String userRecentTaskTime = '30 mins';
  String partnerRecentTaskTime = '1 day';
  String taskSuggestion1 = 'Walk the dog everyday this week';
  String taskSuggestion2 = 'Walk the dog everyday this week';
  String taskSuggestion3 = 'Walk the dog everyday this week';
  String taskSuggestion4 = 'Walk the dog everyday this week';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    Future<User> currentUser = fetchUser(user.uid);
    FutureBuilder<User>(
        future: currentUser,
        // ignore: missing_return
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        userName = snapshot.data.username;
        userBalance = snapshot.data.balance;
        partnerID = snapshot.data.partner_firebase_uid;
      }
      }
    );

    if (partnerID != null) {
      Future<User> partner = fetchUser(partnerID);
      FutureBuilder<User>(
          future: partner,
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              partnerName = snapshot.data.username;
              partnerBalance = snapshot.data.balance;
            }
          }
      );
    }

    Widget userImageNameBalance = Column(
      children: <Widget>[
        CircleImage(
          imagePath: userImagePath
        ),
        Text(
          userName
        ),
        Row(
          children: <Widget>[
            Text(
              'balance '
            ),
            Text(
              userBalance.toString(),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40),
            ),
          ],
        ),

      ],
    );
    Widget partnerImageNameBalance = Column(
      children: <Widget>[
        CircleImage(
          imagePath: partnerImagePath
        ),
        Text(
          partnerName
        ),
        Row(
          children: <Widget>[
            Text(
              'balance '
            ),
            Text(
              partnerBalance.toString(),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40),
            ),
          ],
        ),

      ],
    );
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
            padding: EdgeInsets.symmetric(horizontal:20.0,vertical:15.0),
            margin: EdgeInsets.symmetric(horizontal:20.0,vertical:5.0),
            // height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(14.0),
                topRight: const  Radius.circular(14.0),
                bottomLeft:  const  Radius.circular(14.0),
                bottomRight: const  Radius.circular(14.0)
              ),
            ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
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
                  padding: EdgeInsets.symmetric(horizontal:0.0, vertical: 5.0),
                  child: Text(
                    userName + ': asked ' + partnerName + ' to ' + userMostRecentTask + ' for ' + userRecentTaskPoints.toString() + ' points',
                    style: TextStyle(
                    fontFamily: 'Actor',
                    fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:0.0, vertical: 5.0),
                  child:Text(
                    userRecentTaskTime + 'ago',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:0.0, vertical: 5.0),
                  child: Text(
                    partnerName + ': asked ' + userName + ' to ' + partnerMostRecentTask + ' for ' + partnerRecentTaskPoints.toString() + ' points ',
                    style: TextStyle(
                    fontFamily: 'Actor',
                    fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:0.0, vertical: 5.0),
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
            ),
          );
    Widget taskSuggestions = Container(
            margin: EdgeInsets.symmetric(horizontal:20.0,vertical:5.0),
            padding: EdgeInsets.symmetric(horizontal:20.0,vertical:5.0),
            child:Column(
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
      appBar:AppBar(
        // title: Text('LoveBank'),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
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

class SettingsPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar:AppBar(
        title: Text('Account & Settings'),
        backgroundColor: Colors.yellow[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
    );
  }
}


class ChallengePage extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orange[100],
      appBar:AppBar(
        title: Text('Challenges'),
        backgroundColor: Colors.orange[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
            )
        ]
      ),
    );
  }
}
