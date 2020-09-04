import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

// This method takes a user ID and mobile number, and sends an invite code
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

// This method takes a user ID and invite code, and pairs 2 users
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

// This method takes in a user id and deletes the invite code from the database.
Future revokeBtnClicked(String creatorId, token) async {
  final response = await http.put(
      'https://us-central1-love-bank-9a624.cloudfunctions.net/users-revoke',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'id': creatorId}));
  if (response.statusCode != 200) {
    throw Exception('Failed to revoke the invite');
  }
  return true;
}

Future unlinkBtnClicked(String userId, token) async {
  final response = await http.put(
      'https://us-central1-love-bank-9a624.cloudfunctions.net/users-unlink',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'id': userId}));
  if (response.statusCode != 200) {
    throw Exception('Failed to unlink from partner');
  }
  return true;
}

Future updateBtnClicked(String userId, fieldName, fieldValue, token) async {
  final response = await http.put(
      'https://us-central1-love-bank-9a624.cloudfunctions.net/users-update',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'id': userId,
        'field': fieldName,
        'value': fieldValue
      }));
  if (response.statusCode != 200) {
    throw Exception('Failed to change field');
  }
  return true;
}
