import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

Future inviteBtnClicked(String userId, String mobile, token) async {
  final response = await http.put(
      'https://us-central1-love-bank-9a624.cloudfunctions.net/users-invite',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'action': 'invite',
        'mobile': mobile,
        'id': userId
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future acceptBtnClicked(String userId, String code, token) async {
  final response = await http.put(
      'https://us-central1-love-bank-9a624.cloudfunctions.net/users-accept',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'code': code, 'id': userId}));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

// This method takes in an user id and delete the invite code from the database.
Future revokeBtnClicked(String creatorId, token) async {
  final response = await http.put('https://us-central1-love-bank-9a624.cloudfunctions.net/users-revoke',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'id' : creatorId
      })
  );

  if (response.statusCode == 200){
    return true;
  }

  return false;
}
