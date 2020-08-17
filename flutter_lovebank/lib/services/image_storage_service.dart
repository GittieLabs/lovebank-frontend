import 'dart:io';
import 'dart:convert';
import 'package:uuid/uuid.dart';
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

// This method will upload the image to the firebase storage 
Future uploadFile(File image, String id) async {
  String imageUID = Uuid().v1();
  StorageReference sr = FirebaseStorage.instance.ref().child("$imageUID");
  StorageUploadTask uploadTask = sr.putFile(image);
  await uploadTask.onComplete;

  // Return the photo url
  var fileURL = sr.getDownloadURL();

  return fileURL;
}

// This method will query the firebase storage and delete the image.
deleteFile(String imageURL) async {
  StorageReference sr = await FirebaseStorage.instance.getReferenceFromUrl(imageURL);
  await sr.delete();
}

// This method takes in an user id and update the prfoile picture
// In the case, the user already has a profile picture, 
// the old profile pic will be deleted from the storage 
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

  // Delete the old profile picture from the storage 
  if (response.body.isNotEmpty){
    deleteFile(response.body);
  } 

  return true;
}




