import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/local_user.dart';

Future inviteBtnClicked(String userId, String mobile) async{
  
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
  if (response.statusCode == 200){
    return true;
  }
  return false;
}

Future acceptBtnClicked(String userId, String code) async{
  
  final response = await http.put('http://10.0.2.2:5001/love-bank-9a624/us-central1/accept',
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String>{
      'code' : code,
      'id' : userId
    })
  );
  if (response.statusCode == 200){
    return true;
  }
  return false;
}

// This method takes in an user id and delete the invite code from the database.
Future revokeBtnClicked(String creatorId) async {
  final response = await http.put('http://10.0.2.2:5001/love-bank-9a624/us-central1/revoke',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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