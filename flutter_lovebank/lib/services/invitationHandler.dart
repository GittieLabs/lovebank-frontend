import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

Future inviteBtnClicked(String userId, String mobile) async{
  print(userId);
  print(mobile);
  final response = await http.post('http://10.0.2.2:5001/love-bank-9a624/us-central1/invite',
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String>{
      'action' : 'invite',
      'mobile' : mobile,
      'id' : userId
    })
  );
  // int statusCode = await response.statusCode;
  print(response.statusCode);
  if (response.statusCode == 200){
    print("Working");
    return true;
  }
  print("Not Working");
  return false;
}

Future acceptBtnClicked(String userId, String code) async{
  // print(userId);
  // print(mobile);
  final response = await http.put('http://10.0.2.2:5001/love-bank-9a624/us-central1/accept',
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String>{
      'code' : code,
      'id' : userId
    })
  );
  // int statusCode = await response.statusCode;
  print(response.statusCode);
  if (response.statusCode == 200){
    print("Working");
    return true;
  }
  print("Not Working");
  return false;
}