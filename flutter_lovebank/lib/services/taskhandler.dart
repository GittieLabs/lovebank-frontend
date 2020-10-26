import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

Future createBtnClicked(String id, String description, int points) async {
  final response = await http.put(
      'http://10.0.2.2:5001/love-bank-9a624/us-central1/tasks-create',     headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'description': description,
        'points': points,
        'id': id
      }));
  if (response.statusCode == 200) {
    print(response);
    return true;
  }
  print(response.statusCode);
  return false;
}