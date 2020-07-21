import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  final String userId;
  final String partnerId;
  final String firebaseId;
  final String email;
  final String displayName;
  final String inviteCode;
  final String mobile;
  final int balance;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;

  User({this.userId, this.partnerId, this.firebaseId, this.email,
    this.displayName, this.inviteCode, this.mobile, this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      partnerId: json['partner_id'],
      firebaseId: json['firebase_uid'],
      email: json['email'],
      mobile: json['mobile'],
      displayName: json['username'],
      inviteCode: json['invite_code'],
      balance: json['balance'],
//      tasksCreated: json['tasks_created'],
//      tasksReceived: json['tasks_received']
    );
  }
}


//
//// Test the listener handler
//void main() => runApp(MyApp());
//
//class MyApp extends StatefulWidget {
//  MyApp({Key key}) : super(key: key);
//
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  User futureUser;
//
//  @override
//  void initState() {
//    updateUserListener('tyKTkRKzczvhXhtCKB9m');
//    super.initState();
//  }
//
//  void updateUserListener(String id){
//  DocumentReference reference = Firestore.instance.collection('users').document(id);
//  reference.snapshots().listen((snapshot){
//    if (snapshot.data.isNotEmpty) {
//      setState(() {
//        futureUser = User.fromJson(snapshot.data);
//      });
//    }
//  });
//}
//
//   @override
//  Widget build(BuildContext context) {
//    if (futureUser == null) {
//      return Container();
//    }
//       return MaterialApp(
//           home: Scaffold(
//               backgroundColor: Colors.white,
//               body: SingleChildScrollView(
//                   child: Container(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.all(100),
//                               child: Text(
//                                 futureUser.balance.toString() == null? "error" : futureUser.username.toString(),
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(100),
//                               child: Text(
//                                 futureUser.balance.toString() == null? "error" : futureUser.mobile.toString(),
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                 ),
//                               ),
//                             ),
//                           ]
//                       ))
//               )
//           )
//       );
//   }
//}