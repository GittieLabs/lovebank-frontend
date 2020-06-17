import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(int userId) async {
  final response = await http.get('http://127.0.0.1:5000/user/${userId}');
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class User{
  final int id;
  final int partnerId;
  final String email;
  final String username;

  User({this.id, this.partnerId, this.email, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      partnerId: json['partner_id'],
      email: json['email'],
      username: json['username'],
    );
  }
}








