import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class User{
  var id;
  var firebase_uid;
  var partner_id;
  var partner_firebase_uid;
  var username;
  var invite_code;
  var email;
  var balance;
  var tasks_created;
  var tasks_received;

  User({this.id, this.firebase_uid, this.partner_id, this.partner_firebase_uid, this.username, this.invite_code, this.email, this.balance, this.tasks_created, this.tasks_received});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firebase_uid: json['firebase_uid'],
      partner_id: json['partner_id'],
      partner_firebase_uid: json['partner_firebase_uid'],
      username: json['username'],
      email: json['email'],
      invite_code: json['invite_code'],
      balance: json['balance'],
      tasks_created: json['tasks_created'],
      tasks_received: json['tasks_received'],
    );
  }
}

Future<User> fetchUser(String firebaseId) async {

  final response = await http.get('http://127.0.0.1:5000/users/$firebaseId');
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
