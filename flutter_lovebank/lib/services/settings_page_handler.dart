import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

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
