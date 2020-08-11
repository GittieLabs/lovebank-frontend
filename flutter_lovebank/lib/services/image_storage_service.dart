import 'dart:io';

import "package:firebase_storage/firebase_storage.dart";
import "package:image_picker/image_picker.dart";
import "package:image_picker_platform_interface/image_picker_platform_interface.dart";

Future<String> openGallery() async {
  var picker = ImagePicker();
  var pickedImage = await picker.getImage(source: ImageSource.gallery);

  return pickedImage.path;
}

Future<String> enableCamera() async {
  var picker = ImagePicker();
  var takenPhoto = await picker.getImage(source: ImageSource.camera);

  return takenPhoto.path;
}


