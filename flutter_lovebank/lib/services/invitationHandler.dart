import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

Future inviteBtnClicked(String userId, String mobile, token) async {
  final response = await http.put(
      'http://localhost:5001/love-bank-9a624/us-central1/users-invite',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
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
      'http://localhost:5001/love-bank-9a624/us-central1/users-accept',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'code': code,
        'id': userId
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
