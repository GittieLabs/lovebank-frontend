import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class User{
  final String id;
  final String partnerId;
  final String email;
  final String username;
  final String firebaseId;

  User({this.id, this.partnerId, this.email, this.username, this.firebaseId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firebaseId: json['firebase_uid'],
      partnerId: json['partner_id'],
      email: json['email'],
      username: json['username'],
    );
  }
}

Future<User> fetchUser(FirebaseUser user) async {
  String firebaseId = user.uid;

  final response = await http.get('http://127.0.0.1:5000/user/firebase/$firebaseId');
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}



