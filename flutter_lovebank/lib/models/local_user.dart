import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/userAuthentication.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(String id) async {
  final response =
  await http.get('http://lovebank.herokuapp.com/users/$id');

  if (AuthService.mockAuth) {
      return User(userId: "test_id",partnerId: null,firebaseId: "12345678",email: "test@test.test",username: "test_mctesterson",inviteCode: null,balance: 0);
  }
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User.');
  }
}

class User {
  final String userId;
  final String partnerId;
  final String firebaseId;
  final String email;
  final String username;
  final String inviteCode;
  final int balance;
//  final List tasksCreated;  Not tested yet, will include in the future
//  final List tasksReceived;


  User({this.userId, this.partnerId, this.firebaseId, this.email,
    this.username, this.inviteCode, this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      partnerId: json['partner_id'],
      firebaseId: json['firebase_uid'],
      email: json['email'],
      username: json['username'],
      inviteCode: json['invite_code'],
      balance: json['balance'],
//      tasksCreated: json['tasks_created'],
//      tasksReceived: json['tasks_received']
    );
  }
}
