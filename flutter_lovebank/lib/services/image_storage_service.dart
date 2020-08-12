import 'dart:io';
import 'dart:convert';

import "package:firebase_storage/firebase_storage.dart";
import "package:image_picker/image_picker.dart";
import "package:image_picker_platform_interface/image_picker_platform_interface.dart";
import 'package:http/http.dart' as http;



// This method opens the gallery and returns the chosen photo as a file
Future openGallery() async {
  var picker = ImagePicker();
  var pickedImage = await picker.getImage(source: ImageSource.gallery);

  File image = File(pickedImage.path);
  return image;
}

// This method enables user takes a photo and returns the photo as a file
//Future enableCamera() async {
//  var picker = ImagePicker();
//  var takenPhoto = await picker.getImage(source: ImageSource.camera);
//
//  return takenPhoto;
//}


Future uploadFile(File image, String id) async {
  String timeStamp = new DateTime.now().toString();
  StorageReference sr = FirebaseStorage.instance.ref().child("$id/$timeStamp");
  StorageUploadTask uploadTask = sr.putFile(image);
  await uploadTask.onComplete;

  // Return the photo url
  var fileURL = sr.getDownloadURL();

  return fileURL;
}

// This method takes in an user id and delete the invite code from the database.
Future updateProfilePic(String id, String fileURL, token) async {
  final response = await http.put(
      'http://localhost:5001/love-bank-9a624/us-central1/profile-profilePic',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'id' : id,
        'fileURL' : fileURL
      })
  );

  if (response.statusCode != 200){
    throw Exception('Failed to update the user in the database');
  }

  return true;

}




